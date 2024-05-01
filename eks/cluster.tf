# Create IAM role for the EKS cluster to make calls to AWS APIs on your behalf

resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }

    ]
  })
}
# Policy to help EKS perform cluster setup functions   
# https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonEKSClusterPolicy.html
resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

# vpc_config.subnet_ids controls which subnets the eks control plane enis are placed in

resource "aws_eks_cluster" "eks-cluster" {
  name                      = "${var.project}-${terraform.workspace}-cluster"
  role_arn                  = aws_iam_role.eks-cluster-role.arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.cluster_log_types

  # dynamic_block ?
  vpc_config {
    subnet_ids              = tolist([for subnet in aws_subnet.private : subnet.id])
    endpoint_private_access = var.enable_endpoint_private_access ? true : false
    endpoint_public_access  = var.enable_endpoint_private_access ? false : true

  }

  access_config {
    authentication_mode                         = var.cluster_authentication_mode
    bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  }
  # # Encrypt secrets at rest inside EKS with KMS
  # encryption_config {
  #     provider = 
  #     resources = "secret"
  # }

  depends_on = [aws_iam_role_policy_attachment.eks-cluster-policy]
}

output "environment" {
  value = terraform.workspace
}