output "eks_cluster_id" {
  description = "EKS Cluster Id"
  value       = aws_eks_cluster.eks-cluster.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = aws_eks_cluster.eks-cluster.endpoint
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = var.cluster_name
}

output "k8s_admin_role_arn" {
  description = "Cluster admin role arn"
  value       = aws_iam_role.cluster-admin-k8s[0].arn
}

output "k8s_read_only_role_arn" {
  description = "Cluster read-only role arn"
  value       = aws_iam_role.read_only_k8s[0].arn
}