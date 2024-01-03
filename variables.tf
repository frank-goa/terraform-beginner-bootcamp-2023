variable "user_uuid" {
  type    = string
  default = "" # Default value is set in Terraform Cloud
}

variable "bucket_name" {
  type    = string
  default = "tf-website-2s4b3c9n40y" # Default value is set in Terraform Cloud
}

# variable "index_html_file_path" {
#   type = string
# }

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number
  default     = 1

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}

