data "aws_iam_policy_document" "eks-describe-cluster" {
  count = var.create_cluster_admin_user || var.create_cluster_admin_user ? 1 : 0
  statement {
    sid = "1"

    actions = [
      "eks:DescribeCluster",
    ]

    resources = [
      aws_eks_cluster.eks-cluster.arn,
    ]
  }
}

resource "aws_iam_policy" "eks-describe-cluster" {
  name   = "eks-describe-cluster"
  policy = data.aws_iam_policy_document.eks-describe-cluster[0].json
}



## READ-ONLY-K8s

resource "aws_iam_user" "read-only-k8s" {
  count = var.create_read_only_user ? 1 : 0
  name  = "k8s-read-only-user"
}

resource "aws_iam_role_policy_attachment" "eks-describe-cluster-read-only" {
  count      = var.create_read_only_user ? 1 : 0
  role       = aws_iam_role.read_only_k8s[0].name
  policy_arn = aws_iam_policy.eks-describe-cluster.arn
}

resource "aws_iam_role" "read_only_k8s" {
  count = var.create_read_only_user ? 1 : 0
  name  = "read-only-k8s"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.read-only-k8s[0].arn
        }
      }

    ]
  })
}


resource "aws_eks_access_entry" "read_only" {
  count         = var.create_read_only_user ? 1 : 0
  cluster_name  = aws_eks_cluster.eks-cluster.name
  principal_arn = aws_iam_role.read_only_k8s[0].arn
  type          = "STANDARD"
  user_name     = "READ_ONLY_ENG"
}

resource "aws_eks_access_policy_association" "read_only" {
  count         = var.create_read_only_user ? 1 : 0
  cluster_name  = aws_eks_cluster.eks-cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn = aws_iam_role.read_only_k8s[0].arn

  access_scope {
    type = "cluster"
  }

}

## CLUSTER-ADMIN-K8s

resource "aws_iam_role_policy_attachment" "eks-describe-cluster" {
  count      = var.create_cluster_admin_user ? 1 : 0
  role       = aws_iam_role.cluster-admin-k8s[0].name
  policy_arn = aws_iam_policy.eks-describe-cluster.arn
}
resource "aws_iam_user" "cluster-admin-k8s" {
  name = "k8s-cluster-admin"
}

resource "aws_iam_role" "cluster-admin-k8s" {
  count = var.create_cluster_admin_user ? 1 : 0
  name  = "cluster-admin-k8s"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.cluster-admin-k8s.arn
        }
      }
    ]
  })
}

resource "aws_eks_access_entry" "cluster-admin-k8s" {
  count         = var.create_cluster_admin_user ? 1 : 0
  cluster_name  = aws_eks_cluster.eks-cluster.name
  principal_arn = aws_iam_role.cluster-admin-k8s[0].arn
  type          = "STANDARD"
  user_name     = "CLUSTER-ADMIN-k8s_ENG"
}

resource "aws_eks_access_policy_association" "cluster-admin-k8s" {
  count         = var.create_cluster_admin_user ? 1 : 0
  cluster_name  = aws_eks_cluster.eks-cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_role.cluster-admin-k8s[0].arn

  access_scope {
    type = "cluster"
  }

}