## Main Block
# ASG Module
module "asg" {
  source = "./modules/asg"

  image_ami            = var.image_ami
  instance_type        = var.instance_type
  key_name             = var.key_name
  asg_desired_capacity = var.asg_desired_capacity
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size

  security_group_id = module.security_group.security_group_id
}

# Security Group Module
module "security_group" {
  source = "./modules/security_group"
}

# Codepipeline Module
module "codepipeline" {
  source             = "./modules/codepipeline"

  github_oauth_token = var.github_oauth_token
  asg_name           = module.asg.asg_name
}
