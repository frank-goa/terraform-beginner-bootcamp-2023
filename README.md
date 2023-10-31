# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

[semver.org](https://semver.org/)
- **MAJOR**
- **MINIR**
- **PATCH**


### Generating Random Name as our Bucket Name:

- Created and edited the main.tf file
- add Random Terraform provider

```terraform
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
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
```

- commands used

```bash
terraform init
terraform plan
terraform apply --auto-approve
```


#### Created and Destryed AWS S3 Bucket

- Changed the main.tf file to include AWS Provider
- Checked if everything is working


#### Migrating Terraform state files to Terraform Cloud
- Created API token
- Created env variables in Terraform Cloud
- Need to have proper AWS credentials in our local environment
- Created new project
- Created new workspace in our project