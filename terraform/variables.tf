## Variables block
# Provider Block Variables
variable "aws_region" {}
variable "terraform_infrastructure_deploy_role_arn" {}
variable "session_name" {}

# ASG Module Variables
variable "image_ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "asg_desired_capacity" {}
variable "asg_max_size" {}
variable "asg_min_size" {}

# Codepipeline Module Variables
variable "github_oauth_token" {}