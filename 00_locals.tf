locals {
  owner       = var.owner
  environment = var.environment
  project     = var.project

  common_tags = {
    owner       = local.owner
    environment = local.environment
    project     = local.project
  }


}