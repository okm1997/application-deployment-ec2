# Provider Block
provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = var.terraform_infrastructure_deploy_role_arn
    session_name = var.session_name
  }
}