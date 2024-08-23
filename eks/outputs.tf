output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.eks-cluster.id
}

output "eks_cluster_name" {
  description = "EKS Cluster ARN"
  value       = aws_eks_cluster.eks-cluster.arn
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = aws_eks_cluster.eks-cluster.endpoint
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "k8s_admin_role_arn" {
  description = "Cluster admin role arn"
  value       = aws_iam_role.cluster-admin-k8s[0].arn
}

output "k8s_read_only_role_arn" {
  description = "Cluster read-only role arn"
  value       = aws_iam_role.read_only_k8s[0].arn
}