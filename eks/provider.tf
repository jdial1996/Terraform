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

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }


provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority.data)
    host = aws_eks_clster.aws_eks_cluster.endpoint
  }
}

output "test" {
  value = base64decode(aws_eks_cluster.eks-cluster.certificate_authority.data)
}