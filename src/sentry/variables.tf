/*----------------------------------------------------------------------*/
/* PROJECT | SENTRY                                       */
/*----------------------------------------------------------------------*/

variable "sentry_organization" {
  type = string
  default = "uas-gg"
}
variable "sentry_project_name" {
  type = string
}
variable "teams" {
  type = list(any)
  default = [ "sentry-devops" ]
}
variable "platform" {
  type = string
}
variable "resolve_age" {
  type = number
  default = 720
}

/*----------------------------------------------------------------------*/
/* ISSUES | SENTRY                                       */
/*----------------------------------------------------------------------*/
variable "issue_name" {
  type = string
}
variable "channel_notification_teams" {
  type = string
}
