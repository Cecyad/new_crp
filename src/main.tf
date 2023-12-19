resource "gitlab_project" "repository" {
  name             = var.name_repository
  description      = var.description
  visibility_level = var.visibility_level
  namespace_id     = var.namespace_id
  avatar           = local.project_avatar
  import_url       = ""
}

/*----------------------------------------------------------------------*/
/* BRANCHES | GITLAB                                       */
/*----------------------------------------------------------------------*/
resource "gitlab_branch" "branch" {
  for_each   = var.branches
  name       = each.key
  ref        = "main"
  project    = gitlab_project.repository.id
  depends_on = [gitlab_project.repository]
}

resource "gitlab_branch_protection" "branch_protected" {
  for_each                     = var.branches
  project                      = gitlab_project.repository.id
  branch                       = each.key
  push_access_level            = "maintainer"
  merge_access_level           = "maintainer"
  unprotect_access_level       = "maintainer"
  allow_force_push             = false
  code_owner_approval_required = false

  depends_on = [gitlab_branch.branch]
}
/*----------------------------------------------------------------------*/
/* BADGES | GITLAB                                       */
/*----------------------------------------------------------------------*/
# Pipeline status badges with placeholders will be enabled
resource "gitlab_project_badge" "gitlab_pipeline" {
  project   = gitlab_project.repository.id
  link_url  = "https://gitlab.com/%%{project_path}"
  image_url = "https://gitlab.com/%%{project_path}/badges/%%{default_branch}/pipeline.svg"
  name      = "badge-pipeline"

  depends_on = [gitlab_project.repository]
}

# Test coverage report badges with placeholders will be enabled
resource "gitlab_project_badge" "gitlab_coverage" {
  project   = gitlab_project.repository.id
  link_url  = "https://gitlab.com/%%{project_path}"
  image_url = "https://gitlab.com/%%{project_path}/badges/%%{default_branch}/coverage.svg?job=unittesting"
  name      = "badge-coverage"

  depends_on = [gitlab_project.repository]
}
/*----------------------------------------------------------------------*/
/* VARIABLES | GITLAB                                                   */
/* SOURCE: https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable */
/*----------------------------------------------------------------------*/
resource "gitlab_project_variable" "envs_unittesting" {
  project       = gitlab_project.repository.id
  key           = "envs"
  value         = var.envs
  variable_type = "file"
  depends_on    = [gitlab_project.repository]
}

resource "gitlab_project_variable" "vars" {
  for_each      = var.variables_gitlab_ci
  project       = gitlab_project.repository.id
  key           = each.key
  value         = each.value["value"]
  variable_type = each.value["variable_type"]
  depends_on    = [gitlab_project.repository]
}
/*----------------------------------------------------------------------*/
/* LABELS | GITLAB                                       */
/*----------------------------------------------------------------------*/
resource "gitlab_project_label" "labels" {
  project     = gitlab_project.repository.id
  for_each    = var.labels
  name        = each.value["name"]
  description = each.value["description"]
  color       = each.value["color"]
}

/*----------------------------------------------------------------------*/
/* MR APPROVALS GENERAL SETTINGS | GITLAB                                       */
/*----------------------------------------------------------------------*/
resource "gitlab_project_level_mr_approvals" "general_settings" {
  project                                        = gitlab_project.repository.id
  reset_approvals_on_push                        = true
  disable_overriding_approvers_per_merge_request = false
  merge_requests_author_approval                 = false
  merge_requests_disable_committers_approval     = true
}
/*----------------------------------------------------------------------*/
/* INTEGRATION WITH MICROSOFT TEAMS | GITLAB                            */
/* SOURCE: https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/integration_microsoft_teams */
/*----------------------------------------------------------------------*/
resource "gitlab_integration_microsoft_teams" "teams" {
  project                 = gitlab_project.repository.id
  webhook                 = local.webhook_teams
  push_events             = true
  merge_requests_events   = true
  pipeline_events         = true
  note_events             = true
  branches_to_be_notified = "all"
}
/*----------------------------------------------------------------------*/
/* INTEGRATION WITH SENTRY | GITLAB                                       */
/*----------------------------------------------------------------------*/
module "sentry" {
  count  = var.create_sentry == true ? 1 : 0
  source = "./modules/sentry"

  sentry_project_name        = var.name_repository
  platform                   = var.platform
  issue_name                 = var.name_repository
  channel_notification_teams = var.PROJECT_TRIBE
  teams                      = var.teams
}