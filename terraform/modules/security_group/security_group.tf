# security Group
resource "aws_security_group" "asg_sg" {
  name        = "asg-security-group"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc_id.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Maintainer  = "Terraform"
    Environmnet = "${terraform.workspace}"
  }
}