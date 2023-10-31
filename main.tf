terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length = 16
  special = false
  lower = true
  upper = false
}

output "random_bucket_name" {
  value = random_string.bucket_name.id
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.id

  tags = {
    Name        = "My TF bucket"
    Environment = "TF_environment"
  }
}