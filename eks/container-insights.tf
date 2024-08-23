data "aws_iam_policy_document" "cloudwatch_agent_assume_role" {
  count = var.enable_container_insights ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "cloudwatch_agent_role" {
  count               = var.enable_container_insights ? 1 : 0
  name                = "cloudwatch-agent-role"
  assume_role_policy  = data.aws_iam_policy_document.cloudwatch_agent_assume_role[0].json
  managed_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
}

resource "aws_eks_pod_identity_association" "cloudwatch_agent_pod_identity" {
  count           = var.enable_container_insights ? 1 : 0
  cluster_name    = aws_eks_cluster.eks-cluster.name
  namespace       = var.cloudwatch_observability_namespace
  service_account = var.cloudwatch_observability_service_account_name
  role_arn        = aws_iam_role.cloudwatch_agent_role[0].arn
}