# ASG data block
data "aws_vpc" "default_vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["elred-default-vpc"]
  }
}

data "aws_subnets" "aws_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc_id.id]
  }
}