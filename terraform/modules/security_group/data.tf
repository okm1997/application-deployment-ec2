# Security Group Data Block
data "aws_vpc" "default_vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["elred-default-vpc"]
  }
}