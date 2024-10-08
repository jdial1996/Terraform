terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
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
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority[0].data)
    host                   = aws_eks_cluster.eks-cluster.endpoint

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks-cluster.id]
    }
  }
}
# Required for NodeTemplate and Nodepool

provider "kubectl" {
  host                   = aws_eks_cluster.eks-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks-cluster.id]
  }
  load_config_file = false
}