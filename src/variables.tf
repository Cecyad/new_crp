/*----------------------------------------------------------------------*/
/* ENVIRONMENT VARIABLES FROM .ENV | GITLAB                                       */
/*----------------------------------------------------------------------*/
variable "PROJECT_TYPE" {
  type        = string
  description = "Project type"
}
variable "PROJECT_TRIBE" {
  type        = string
  description = "Project type"
}
variable "GITLAB_USERNAME" {
  type        = string
  description = "Gitlab username"
}
variable "GITLAB_ACCESS_TOKEN" {
  type        = string
  description = "Gitlab access token"
}
/*----------------------------------------------------------------------*/
/* REPOSITORY | GITLAB                                       */
/*----------------------------------------------------------------------*/
variable "namespace_id" {
  type        = number
  description = "Namespace Group ID"
}
variable "name_repository" {
  type        = string
  description = "Repository Name"
}
variable "description" {
  type        = string
  description = "Description Repository"
}
variable "visibility_level" {
  type        = string
  description = "visibility of level"
  default     = "private"
}
/*----------------------------------------------------------------------*/
/* BRANCHES | GITLAB                                       */
/*----------------------------------------------------------------------*/
variable "branches" {
  type        = map(any)
  description = "Repository Branches"
}
/*----------------------------------------------------------------------*/
/* VARIABLES | GITLAB                                       */
/*----------------------------------------------------------------------*/
variable "envs" {
  type        = string
  description = "GitLab-CI Variable for Unittesting stage"
}

variable "variables_gitlab_ci" {
  type        = map(any)
  description = "Any var Gitlab Repository"
  default     = {}
}
/*----------------------------------------------------------------------*/
/* LABELS | GITLAB                                       */
/*----------------------------------------------------------------------*/
variable "labels" {
  # TODO: Get labels from file --> Owner: Cecilia
  type        = map(any)
  description = "Label Name"
  default = {
    # Team Labels
    foundations = {
      name        = "team::Foundations",
      description = "",
      color       = "#ffa500"
    },
    observability = {
      name        = "team::Observability",
      description = "",
      color       = "#ffa500"
    },
    database_reliability = {
      name        = "team::Database Reliability",
      description = "",
      color       = "#ffa500"
    },
    practices = {
      name        = "team::Practices",
      description = "",
      color       = "#ffa500"
    },
    general = {
      name        = "team::General",
      description = "",
      color       = "#ffa500"
    }
  }
}

