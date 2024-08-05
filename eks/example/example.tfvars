project="lab"
environment="development"
region="eu-west-2"

## Network 
vpc_cidr="10.0.0.0/16"
public_subnet_cidrs = {
    "eu-west-2a" : "10.0.101.0/24",
    "eu-west-2b" : "10.0.102.0/24",
    "eu-west-2c" : "10.0.103.0/24"
  }

private_subnet_cidrs = {
    "eu-west-2a" : "10.0.104.0/24",
    "eu-west-2b" : "10.0.105.0/24",
    "eu-west-2c" : "10.0.106.0/24"
  }

## EKS Cluster 
cluster_name="my_cluster"
enable_endpoint_private_access=false
kubernetes_version="1.28"
cluster_log_types=["audit","api"]
cluster_authentication_mode="API_AND_CONFIG_MAP"
bootstrap_cluster_creator_admin_permissions=true

## Cluster Nodegroups

# Managed Nodegroup

enable_managed_nodegroups = true 
nodegroups= {
    nodegroup1 = {
        desired_nodes = 1
        max_nodes = 2 
        min_nodes = 1
        instance_type = "t2.small"
        capacity_type = "ON_DEMAND"
        max_unavailable_nodes = 1
    }
}

# Fargate

enable_eks_fargate_profiles = false
eks_fargate_profiles = {
    fargate_profile1 = {
        name = "test"
        namespace = "fargate"
    }
}

## RBAC - K8s

create_read_only_user = true
create_cluster_admin_user = true 
create_lb_controller = true
lb_controller_namespace = "kube-system" 
lb_controller_service_account_name = "aws-load-balancer-controller"

## EKS Addons

pod_identity_addon_version = "v1.3.0-eksbuild.1"