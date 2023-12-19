locals {
  project_avatar = var.PROJECT_TYPE == var.grpc ? var.icon_grpc : var.PROJECT_TYPE == var.api ? var.icon_api : var.PROJECT_TYPE == var.cron ? var.icon_cron : var.PROJECT_TYPE == var.lambda ? var.icon_lambda : var.icon_empty
}