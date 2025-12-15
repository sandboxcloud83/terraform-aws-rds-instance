# examples/providers.tf

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Región de prueba
  
  default_tags {
    tags = {
      Environment = "Example"
      Project     = "Terraform-Brick-RDS"
      ManagedBy   = "Terraform"
    }
  }
}
