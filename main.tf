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



# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration#argument-reference
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.tf-website-bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
# https://developer.hashicorp.com/terraform/language/expressions/references
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.tf-website-bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.root}/public/index.html")
}
