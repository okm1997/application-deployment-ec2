# Backend Block
terraform {
  backend "s3" {
    bucket         = "elred-terraform-backend"
    key            = "backend.tfstate"
    region         = "us-east-1"
    dynamodb_table = "s3-tf-state-lock"
  }
}