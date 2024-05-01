# Create workder nodegroups for EKS cluster
# Nodegroups will also need their own IAM role

resource "aws_iam_role" "nodegroup_role" {
  name = "eks-node-group-role"
  # jsonencode() convers an object to json
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Policies - EKS node kubelet makes calls to AWS APIs on your behalf

# This policy grants access to EC2 and EKS
resource "aws_iam_role_policy_attachment" "eks-nodegroup-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodegroup_role.name
}


resource "aws_iam_role_policy_attachment" "eks-worker-node-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodegroup_role.name
}


# This policy allows the worker nodes to download and run docker images from an ECR repository
resource "aws_iam_role_policy_attachment" "eks-worker-node-ecr-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodegroup_role.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-logs-policy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = aws_iam_role.nodegroup_role.name
}



resource "aws_eks_node_group" "nodegroup" {
  for_each        = var.enable_managed_nodegroups ? var.nodegroups : {}
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = each.key
  version         = var.kubernetes_version
  node_role_arn   = aws_iam_role.nodegroup_role.arn #

  subnet_ids     = values(aws_subnet.private)[*].id
  instance_types = [each.value.instance_type]

  capacity_type = each.value.capacity_type
  # EKS by itself will not autosclae your nodes.  We also need to deploy the cluster autoscaler.  We can however define minimum and maximum number of nodes
  scaling_config {
    desired_size = each.value.desired_nodes
    max_size     = each.value.max_nodes
    min_size     = each.value.min_nodes
  }

  update_config {
    # desired number of unavailable nodes during nodegroup updates
    max_unavailable = each.value.max_unavailable_nodes
  }

  # create labels and taints for your pods here 
  labels = {
    role = "General"
  }
}

# Lets you specify which pods will be hosted on fargate
resource "aws_eks_fargate_profile" "fargate_profile" {
  for_each               = var.enable_eks_fargate_profiles ? var.eks_fargate_profiles : {}
  cluster_name           = aws_eks_cluster.eks-cluster.name
  fargate_profile_name   = each.key
  pod_execution_role_arn = aws_iam_role.nodegroup_role.arn
  subnet_ids             = values(aws_subnet.private)[*].id

  selector {
    namespace = each.value.namespace
  }
}

# fargate requires aws cloudmap as containers are immutable by nature.  when container goes down you need to register the new and deregister the old.  
# To do this on your own is challenging you so you need service discovery: cloudmap