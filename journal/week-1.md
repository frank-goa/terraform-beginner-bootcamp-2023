# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our Root Module Structure is as follows:


```
PROJECT ROOT
│
├── main.tf                 # everything else
├── variables.tf            # stores the structure of input variables
├── providers.tf            # defines required providers and their configuration
├── outputs.tf              # stores our outputs
├── terrafrom.tfvars        # the data of variables we want to load into our Terraform project
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)