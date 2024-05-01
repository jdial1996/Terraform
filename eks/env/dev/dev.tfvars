project="webkat"
environment="development"
vpc_cidr="10.0.0.0/16"
enable_endpoint_private_access=true
kubernetes_version=""
cluster_log_types=["audit","api"]
cluster_authentication_mode="API_AND_CONFIG_MAP"
bootstrap_cluster_creator_admin_permissions=true
min_nodes=1
max_nodes=2
desired_nodes=3
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
enable_managed_nodegroups = true 
enable_eks_fargate_profiles = true
eks_fargate_profiles = {
    fargate_profile1 = {
        name = "test"
        namespace = "fargate"
    }
}