resource "helm_release" "metrics_server" {
  count    = var.enable_hpa ? 1 : 0
  provider = "helm"
  depends_on = [
    aws_eks_cluster.eks-cluster
  ]

  name             = "metrics-server"
  namespace        = var.hpa_namespace
  repository       = "https://kubernetes-sigs.github.io/metrics-server"
  chart            = "metrics-server"
  version          = var.metrics_server_version
}
