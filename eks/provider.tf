terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}