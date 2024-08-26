resource "helm_release" "metrics_server" {
  count    = var.enable_metrics_server ? 1 : 0
  provider = "helm"
  depends_on = [
    aws_eks_cluster.eks-cluster,
    helm_release.karpenter
  ]

  name       = "metrics-server"
  namespace  = var.metrics_server_namespace
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  version    = var.metrics_server_version
}

