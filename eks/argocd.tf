resource "helm_release" "argocd" {
  
  count    = var.enable_argocd ? 1 : 0
  provider = "helm"
  depends_on = [
    aws_eks_cluster.eks-cluster,
    helm_release.karpenter
  ]

  name             = "argocd"
  namespace        = var.argocd_namespace
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_version
  create_namespace = true
}

