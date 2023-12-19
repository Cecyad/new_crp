output "group_id" {
  description = "ID of group"
  value       = gitlab_project.repository.id
}
output "project_path_with_namespace" {
  description = "ID of group"
  value       = gitlab_project.repository.path_with_namespace
}
output "credentials" {
  description = "DSN credentials"
  value       = join(" ", module.sentry[*].dsn_public)
}
