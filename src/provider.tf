terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 16.2.0"
    }
  }
}

provider "gitlab" {}
