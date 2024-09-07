resource "aws_iam_policy" "karpenter_policy" {
  count       = var.enable_karpenter ? 1 : 0
  name        = "controller-policy"
  description = "IAM policy for Karpenter controller"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Karpenter"
        Effect = "Allow"
        Action = [
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
        Sid      = "ConditionalEC2Termination"
        Effect   = "Allow"
        Action   = "ec2:TerminateInstances"
        Resource = "*"
        Condition = {
          StringLike = {
            "ec2:ResourceTag/karpenter.sh/nodepool" = "*"
          }
        }
      },
      {
        Sid      = "PassNodeIAMRole"
        Effect   = "Allow"
        Action   = "iam:PassRole"
        Resource = "${aws_iam_role.nodegroup_role.arn}"
      },
      {
        Sid      = "EKSClusterEndpointLookup"
        Effect   = "Allow"
        Action   = "eks:DescribeCluster"
        Resource = "${aws_eks_cluster.eks-cluster.arn}"
      },
      {
        Sid      = "AllowScopedInstanceProfileCreationActions"
        Effect   = "Allow"
        Action   = ["iam:CreateInstanceProfile"]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestTag/kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.id}" = "owned",
            "aws:RequestTag/topology.kubernetes.io/region"                           = "${var.region}"
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
            "aws:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.id}" = "owned",
            "aws:ResourceTag/topology.kubernetes.io/region"                           = "${var.region}",
            "aws:RequestTag/kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.id}"  = "owned",
            "aws:RequestTag/topology.kubernetes.io/region"                            = "${var.region}"
          }
          StringLike = {
            "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass" = "*",
            "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass"  = "*"
          }
        }
      },
      {
        Sid    = "AllowScopedInstanceProfileActions"
        Effect = "Allow"
        Action = [
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:DeleteInstanceProfile"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/kubernetes.io/cluster/${aws_eks_cluster.eks-cluster.id}" = "owned",
            "aws:ResourceTag/topology.kubernetes.io/region"                           = "${var.region}"
          }
          StringLike = {
            "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass" = "*"
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

resource "aws_ec2_tag" "karpenter_tag" {
  count       = var.enable_karpenter ? 1 : 0
  resource_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
  key         = "karpenter.sh/discovery"
  value       = aws_eks_cluster.eks-cluster.id
}

resource "aws_iam_instance_profile" "karpenter_instance_profile" {
  name = "karpenter-instance-profile"
  role = aws_iam_role.nodegroup_role.name
}


## Karpenter Nodepool and Nodeclass CRD


resource "kubectl_manifest" "karpenter_nodepool" {
  provider      = "kubectl"
  depends_on    = [kubectl_manifest.karpenter_ec2nodeclass]
  ignore_fields = ["metadata", "status", "yaml_incluster"]

  count     = var.enable_karpenter ? 1 : 0
  yaml_body = <<YAML
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  template:
    metadata:
      labels:
        type: karpenter
    spec:
      requirements:
        - key: "karpenter.sh/capacity-type"
          operator: In
          values: ["spot"]
        - key: "node.kubernetes.io/instance-type"
          operator: In
          values: [${join(", ", formatlist("\"%s\"", var.karpenter_acceptable_instance_types))}]
      nodeClassRef:
        name: default
  limits:
    cpu: "1000"
    memory: 1000Gi
  disruption:
    consolidationPolicy: WhenUnderutilized
    expireAfter: 720h
YAML
}


resource "kubectl_manifest" "karpenter_ec2nodeclass" {
  depends_on    = [helm_release.karpenter]
  ignore_fields = ["metadata", "status", "yaml_incluster"]
  provider      = "kubectl"
  count         = var.enable_karpenter ? 1 : 0
  yaml_body     = <<YAML
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiFamily: AL2023 # Amazon Linux 2023
  instanceProfile: "${aws_iam_instance_profile.karpenter_instance_profile.id}"
  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: "${aws_eks_cluster.eks-cluster.id}"
  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: "${aws_eks_cluster.eks-cluster.id}"
YAML
}

###


resource "helm_release" "karpenter" {
  count    = var.enable_karpenter ? 1 : 0
  provider = "helm"
  depends_on = [
    aws_eks_cluster.eks-cluster,
    aws_eks_addon.pod-identity
  ]

  name             = "karpenter"
  namespace        = var.karpenter_namespace
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  version          = var.karpenter_version
  create_namespace = true
  wait             = true ## wait until provisioner crd has been installed

  set {
    name  = "settings.clusterName"
    value = aws_eks_cluster.eks-cluster.id
  }
  set {
    name  = "settings.clusterEndpoint"
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

resource "time_sleep" "wait_30_seconds" {
  depends_on = [helm_release.karpenter]

  create_duration = "30s"
}