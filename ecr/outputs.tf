output "repository_url" {
  description = "The ECR Repository URI"
  value       = aws_ecr_repository.ecr_repository.repository_url
}

output "registry_id" {
  description = "The ECR Registry Id"
  value       = aws_ecr_repository.ecr_repository.registry_id
}