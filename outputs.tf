output "bucket_name" {
  value = var.bucket_name
}
output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}