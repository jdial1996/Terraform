resource "helm_release" "prometheus_stack" {
  count    = var.enable_monitoring ? 1 : 0
  provider = "helm"
  depends_on = [
    aws_eks_cluster.eks-cluster,
    helm_release.karpenter,
    time_sleep.wait_30_seconds
  ]

  name       = "prometheus-stack"
  namespace  = var.monitoring_namespace #monitoring
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.kube_prometheus_version  #61.9.0
  create_namespace = true
}




