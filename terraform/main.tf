terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Load other Terraform components
module "lambda" {
  source = "./lambda.tf"
}

module "api_gateway" {
  source = "./api_gateway.tf"
}

module "dynamodb" {
  source = "./dynamodb.tf"
}
