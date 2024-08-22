resource "aws_iam_policy" "karpenter_policy" {
  count = var.enable_karpenter ? 1 : 0
  name        = "controller-policy"
  description = "IAM policy for Karpenter controller"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Karpenter"
        Effect    = "Allow"
        Action    = [
          "ssm:GetParameter",
          "ec2:DescribeImages",
          "ec2:RunInstances",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeAvailabilityZones",
          "ec2:DeleteLaunchTemplate",
          "ec2:CreateTags",
          "ec2:CreateLaunchTemplate",
          "ec2:CreateFleet",
          "ec2:DescribeSpotPriceHistory",
          "pricing:GetProducts"
        ]
        Resource = "*"
      },
      {
        Sid       = "ConditionalEC2Termination"
        Effect    = "Allow"
        Action    = "ec2:TerminateInstances"
        Resource  = "*"
        Condition = {
          StringLike = {
            "ec2:ResourceTag/karpenter.sh/nodepool" = "*"
          }
        }
      },
      {
        Sid    = "PassNodeIAMRole"
        Effect = "Allow"
        Action = "iam:PassRole"
        Resource = "${aws_iam_role.nodegroup_role.arn}"
      },
      {
        Sid    = "EKSClusterEndpointLookup"
        Effect = "Allow"
        Action = "eks:DescribeCluster"
        Resource = "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/${var.cluster_name}"
      },
      {
        Sid      = "AllowScopedInstanceProfileCreationActions"
        Effect   = "Allow"
        Action   = ["iam:CreateInstanceProfile"]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestTag/kubernetes.io/cluster/${var.cluster_name}"       = "owned",
            "aws:RequestTag/topology.kubernetes.io/region"                   = "${var.region}"
          }
          StringLike = {
            "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass" = "*"
          }
        }
      },
      {
        Sid      = "AllowScopedInstanceProfileTagActions"
        Effect   = "Allow"
        Action   = ["iam:TagInstanceProfile"]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/kubernetes.io/cluster/${var.cluster_name}"       = "owned",
            "aws:ResourceTag/topology.kubernetes.io/region"                   = "${var.region}",
            "aws:RequestTag/kubernetes.io/cluster/${var.cluster_name}"        = "owned",
            "aws:RequestTag/topology.kubernetes.io/region"                    = "${var.region}"
          }
          StringLike = {
            "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass"                  = "*",
            "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass"                   = "*"
          }
        }
      },
      {
        Sid      = "AllowScopedInstanceProfileActions"
        Effect   = "Allow"
        Action   = [
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:DeleteInstanceProfile"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/kubernetes.io/cluster/${var.cluster_name}"       = "owned",
            "aws:ResourceTag/topology.kubernetes.io/region"                   = "${var.region}"
          }
          StringLike = {
            "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass"                  = "*"
          }
        }
      },
      {
        Sid      = "AllowInstanceProfileReadActions"
        Effect   = "Allow"
        Action   = "iam:GetInstanceProfile"
        Resource = "*"
      }
    ]
  })
}



data "aws_iam_policy_document" "karpenter_assume_role" {
  count = var.enable_karpenter ? 1 : 0
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

resource "aws_iam_role" "karpenter_role" {
  count              = var.enable_karpenter ? 1 : 0
  name               = "karpenter-role"
  assume_role_policy = data.aws_iam_policy_document.karpenter_assume_role[0].json
}

resource "aws_iam_role_policy_attachment" "karpenter_role_attachment" {
  count      = var.enable_karpenter ? 1 : 0
  policy_arn = aws_iam_policy.karpenter_policy[0].arn
  role       = aws_iam_role.karpenter_role[0].name
}

resource "aws_eks_pod_identity_association" "karpenter_pod_identity" {
  count           = var.enable_karpenter ? 1 : 0
  cluster_name    = aws_eks_cluster.eks-cluster.name
  namespace       = var.karpenter_namespace
  service_account = var.karpenter_service_account_name
  role_arn        = aws_iam_role.karpenter_role[0].arn
}


## Helm - Karpenter

# Add tag to eks cluster primary security group

# data "aws_security_group" "eks_primary_security_group" {
#   id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
# }


resource "aws_ec2_tag" "karpenter_tag" {
  count = var.create_lb_controller ? 1 : 0
  resource_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
  key         = "karpenter.sh/discovery"
  value       = aws_eks_cluster.eks-cluster.id
}

resource "aws_iam_instance_profile" "karpenter_instance_profile" {
  name = "karpenter-instance-profile"
  role = aws_iam_role.nodegroup_role.name 
}


resource "helm_release" "karpenter" {
  count           = var.enable_karpenter ? 1 : 0
  provider = "helm"
  depends_on = [
    aws_eks_cluster.eks-cluster
  ]

  name             = "karpenter"
  namespace        = var.karpenter_namespace
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  version          = var.karpenter_version
  create_namespace = true
  wait = true ## wait until provisioner crd has been installed

  set {
    name  = "settings.clusterName"
    value = var.cluster_name
  }
  set {
    name = "settings.clusterEndpoint"
    value = aws_eks_cluster.eks-cluster.endpoint
  }
  set {
    name  = "serviceAccount.create"
    value = true
  }
  set {
    name  = "serviceAccount.name"
    value = var.karpenter_service_account_name
  }
}
