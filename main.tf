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

module "template_files" {
    source = "hashicorp/dir/template"

    base_dir = "${path.module}/public"
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
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.tf-website-bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.root}/public/index.html")
  lifecycle {
    replace_triggered_by = [ terraform_data.content_version.output ]
    ignore_changes = [ etag ]
  }
  
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.tf-website-bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.root}/public/index.html")
  lifecycle {
    replace_triggered_by = [ terraform_data.content_version.output ]
    ignore_changes = [ etag ]
  }
  
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}

resource "terraform_data" "content_version" {
  input = var.content_version
}

# resource "aws_s3_object" "upload_assets" {
#   # for_each = fileset(var.public_path, "*.{jpg,png,gif}")
#   for_each = fileset("${path.root}/assets","*.{jpg,png,gif}")
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "assets/${each.key}"
#   source = "${path.root}/assets/${each.key}"
#   # content_type = "text/html"

#   etag = filemd5("${path.root}/assets/${each.key}")
#   lifecycle {
#     replace_triggered_by = [ terraform_data.content_version.output ]
#     ignore_changes = [ etag ]
#   }
# }