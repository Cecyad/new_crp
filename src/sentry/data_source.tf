/*----------------------------------------------------------------------*/
/* KEY | SENTRY                                       */
/*----------------------------------------------------------------------*/
data "sentry_key" "default" {
  organization = var.sentry_organization
  project      = sentry_project.default.id

  first = true
}