/*----------------------------------------------------------------------*/
/* PROJECT | SENTRY                                       */
/*----------------------------------------------------------------------*/
resource "sentry_project" "default" {
  organization = var.sentry_organization

  teams = var.teams
  name  = var.sentry_project_name

  platform    = var.platform
  resolve_age = var.resolve_age
}
/*----------------------------------------------------------------------*/
/* ISSUE | SENTRY                                       */
/*----------------------------------------------------------------------*/
resource "sentry_issue_alert" "main" {
  organization = sentry_project.default.organization
  project      = sentry_project.default.id
  name         = "${var.issue_name}"

  action_match = "any"
  filter_match = "any"
  frequency    = 15
  environment = "production"

  conditions =  [{
    id = "sentry.rules.conditions.every_event.EveryEventCondition"
  }]
  filters = []
  # actions = data.sentry_issue_alert.original.actions
  actions = [
    {
      id = "sentry.integrations.msteams.notify_action.MsTeamsNotifyServiceAction"
      channel = var.channel_notification_teams
      # change workspace to team - from id integration msteams
      team = 193654
    }
  ]
  depends_on = [ sentry_project.default ]
}
