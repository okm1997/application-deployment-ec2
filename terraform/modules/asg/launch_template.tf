# ASG Launch Template
resource "aws_launch_template" "app" {
  name          = "nginx-app-${terraform.workspace}"
  image_id      = var.image_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/userdata.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_group_id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.codedeploy_instance_profile.name
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Maintainer  = "Terraform"
      Environmnet = "${terraform.workspace}"
    }
  }
}