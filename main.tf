terraform {
  required_providers {
    
    aws = {
      source = "hashicorp/aws"
      version = "5.23.1"
    }
  }

  cloud {
    organization = "my_cloud_journey"

    workspaces {
      name = "terra-house-1"
    }
  }
}


provider "aws" {
  # Configuration options
  region = "us-east-1"
}


resource "aws_s3_bucket" "tf-website-bucket" {
  bucket =  var.bucket_name

  tags = {
    Name        = "My TF bucket"
    Environment = "TF_environment"
    User_UUID = var.user_uuid
  }
}