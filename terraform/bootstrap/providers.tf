terraform {
  required_version = ">= 1.7"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.50" }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "paysense"
  default_tags {
    tags = {
      Project   = "paysense"
      ManagedBy = "terraform"
      Owner     = "Yash-Rathod"
    }
  }
}

data "aws_caller_identity" "current" {}
