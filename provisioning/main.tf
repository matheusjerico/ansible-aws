terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


provider "aws" {
  region                  = "us-east-2"
  shared_credentials_file = "/home/user/.aws/credentials"
}


terraform {
  backend "s3" {
    bucket = "s3-terraform"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}