## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eip) | resource |
| [aws_eks_cluster.eks-cluster](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.nodegroup](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_node_group) | resource |
| [aws_iam_role.eks-cluster-role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role.nodegroup_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks-cluster-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-nodegroup-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-worker-node-cni-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-worker-node-ecr-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-worker-node-logs-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_cluster_creator_admin_permissions"></a> [bootstrap\_cluster\_creator\_admin\_permissions](#input\_bootstrap\_cluster\_creator\_admin\_permissions) | Enable automatic grant of cluster-admin-creator to IAM entity that created the cluster | `bool` | n/a | yes |
| <a name="input_cluster_authentication_mode"></a> [cluster\_authentication\_mode](#input\_cluster\_authentication\_mode) | The cluster authentication mode for IAM principles. | `string` | n/a | yes |
| <a name="input_cluster_log_types"></a> [cluster\_log\_types](#input\_cluster\_log\_types) | The desired controlplane logging to enable.  Valid values: api \| audit \| authenticator \| scheduler \| controller-manager | `list(string)` | n/a | yes |
| <a name="input_desired_nodes"></a> [desired\_nodes](#input\_desired\_nodes) | The desired number of nodes in the default nodegroup | `number` | n/a | yes |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Allocate public hostname for instances with IPv4 | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enables DNS resolution of hostnames within the VPC. | `bool` | `true` | no |
| <a name="input_enable_endpoint_private_access"></a> [enable\_endpoint\_private\_access](#input\_enable\_endpoint\_private\_access) | Enables DNS resolution of hostnames within the VPC. | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The project nvironment. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The underlying version of Kubernetes for EKS | `string` | n/a | yes |
| <a name="input_max_nodes"></a> [max\_nodes](#input\_max\_nodes) | The maximum number of nodes in the default nodegroup | `number` | n/a | yes |
| <a name="input_min_nodes"></a> [min\_nodes](#input\_min\_nodes) | The minimum number of nodes in the default nodegroup | `number` | n/a | yes |
| <a name="input_nodegroups"></a> [nodegroups](#input\_nodegroups) | The eks cluster nodegroup configurations | `map(any)` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | n/a | `map(any)` | <pre>{<br>  "eu-west-2a": "10.0.104.0/24",<br>  "eu-west-2b": "10.0.105.0/24",<br>  "eu-west-2c": "10.0.106.0/24"<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the project. | `string` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | n/a | `map(any)` | <pre>{<br>  "eu-west-2a": "10.0.101.0/24",<br>  "eu-west-2b": "10.0.102.0/24",<br>  "eu-west-2c": "10.0.103.0/24"<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the EKS Cluster VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
| <a name="output_private_subnet_details"></a> [private\_subnet\_details](#output\_private\_subnet\_details) | n/a |
| <a name="output_public_subnet_details"></a> [public\_subnet\_details](#output\_public\_subnet\_details) | n/a |
| <a name="output_test"></a> [test](#output\_test) | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eip) | resource |
| [aws_eks_access_entry.cluster-admin-k8s](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_access_entry) | resource |
| [aws_eks_access_entry.read_only](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_access_entry) | resource |
| [aws_eks_access_policy_association.cluster-admin-k8s](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_access_policy_association.read_only](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_access_policy_association) | resource |
| [aws_eks_addon.cloudwatch-observability](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.ebs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_addon) | resource |
| [aws_eks_addon.pod-identity](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.eks-cluster](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_cluster) | resource |
| [aws_eks_fargate_profile.fargate_profile](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_fargate_profile) | resource |
| [aws_eks_node_group.nodegroup](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_node_group) | resource |
| [aws_eks_pod_identity_association.cloudwatch_agent_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_pod_identity_association) | resource |
| [aws_eks_pod_identity_association.karpenter_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_pod_identity_association) | resource |
| [aws_eks_pod_identity_association.lb_controller_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/eks_pod_identity_association) | resource |
| [aws_iam_policy.eks-describe-cluster](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.karpenter_policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lb_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.cloudwatch_agent_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster-admin-k8s](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role.eks-cluster-role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role.karpenter_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role.lb_controller_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role.nodegroup_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role.read_only_k8s](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks-cluster-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-describe-cluster](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-describe-cluster-read-only](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-nodegroup-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-worker-node-cni-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-worker-node-ebs-csi-driver](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-worker-node-ecr-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks-worker-node-logs-policy](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lb_controller_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.cluster-admin-k8s](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_user) | resource |
| [aws_iam_user.read-only-k8s](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/iam_user) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/resources/vpc) | resource |
| [helm_release.aws_loadbalancer_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudwatch_agent_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks-describe-cluster](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.karpenter_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lb_controller_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.46.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_cluster_creator_admin_permissions"></a> [bootstrap\_cluster\_creator\_admin\_permissions](#input\_bootstrap\_cluster\_creator\_admin\_permissions) | Enable automatic grant of cluster-admin-creator to IAM entity that created the cluster | `bool` | n/a | yes |
| <a name="input_cloudwatch_observability_addon_version"></a> [cloudwatch\_observability\_addon\_version](#input\_cloudwatch\_observability\_addon\_version) | The version of the EBS CSI Driver addon. | `string` | `null` | no |
| <a name="input_cloudwatch_observability_namespace"></a> [cloudwatch\_observability\_namespace](#input\_cloudwatch\_observability\_namespace) | The namespace to deploy the Cloudwatch Agent in. | `string` | `"amazon-cloudwatch"` | no |
| <a name="input_cloudwatch_observability_service_account_name"></a> [cloudwatch\_observability\_service\_account\_name](#input\_cloudwatch\_observability\_service\_account\_name) | The  CloudWatch Agent Kubernetes service account name. | `string` | `"cloudwatch-agent"` | no |
| <a name="input_cluster_authentication_mode"></a> [cluster\_authentication\_mode](#input\_cluster\_authentication\_mode) | The cluster authentication mode for IAM principles. | `string` | n/a | yes |
| <a name="input_cluster_log_types"></a> [cluster\_log\_types](#input\_cluster\_log\_types) | The desired controlplane logging to enable.  Valid values: api \| audit \| authenticator \| scheduler \| controller-manager | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_create_cluster_admin_user"></a> [create\_cluster\_admin\_user](#input\_create\_cluster\_admin\_user) | Create an EKS cluster admin user. | `bool` | n/a | yes |
| <a name="input_create_lb_controller"></a> [create\_lb\_controller](#input\_create\_lb\_controller) | Create AWS LB Controller for EKS. | `bool` | n/a | yes |
| <a name="input_create_read_only_user"></a> [create\_read\_only\_user](#input\_create\_read\_only\_user) | Create an EKS read only user. | `bool` | n/a | yes |
| <a name="input_ebs_csi_driver_addon_version"></a> [ebs\_csi\_driver\_addon\_version](#input\_ebs\_csi\_driver\_addon\_version) | The version of the EBS CSI Driver addon. | `string` | `null` | no |
| <a name="input_eks_fargate_profiles"></a> [eks\_fargate\_profiles](#input\_eks\_fargate\_profiles) | The eks cluster nodegroup configurations | `map(any)` | n/a | yes |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | Feature switch for Container Insights | `bool` | n/a | yes |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Allocate public hostname for instances with IPv4 | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enables DNS resolution of hostnames within the VPC. | `bool` | `true` | no |
| <a name="input_enable_ebs_csi_driver"></a> [enable\_ebs\_csi\_driver](#input\_enable\_ebs\_csi\_driver) | Feature switch for EBS CSI Driver | `bool` | `false` | no |
| <a name="input_enable_eks_fargate_profiles"></a> [enable\_eks\_fargate\_profiles](#input\_enable\_eks\_fargate\_profiles) | Feature switch for managed nodegroups | `bool` | n/a | yes |
| <a name="input_enable_endpoint_private_access"></a> [enable\_endpoint\_private\_access](#input\_enable\_endpoint\_private\_access) | Enables DNS resolution of hostnames within the VPC. | `bool` | n/a | yes |
| <a name="input_enable_karpenter"></a> [enable\_karpenter](#input\_enable\_karpenter) | Feature switch for Karpenter | `bool` | n/a | yes |
| <a name="input_enable_managed_nodegroups"></a> [enable\_managed\_nodegroups](#input\_enable\_managed\_nodegroups) | Feature switch for managed nodegroups | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The project environment. | `string` | n/a | yes |
| <a name="input_karpenter_namespace"></a> [karpenter\_namespace](#input\_karpenter\_namespace) | The namespace to deploy Karpenter in. | `string` | n/a | yes |
| <a name="input_karpenter_version"></a> [karpenter\_version](#input\_karpenter\_version) | The Helm Chart version of Karpenter to install. | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The underlying version of Kubernetes for EKS | `string` | n/a | yes |
| <a name="input_lb_controller_namespace"></a> [lb\_controller\_namespace](#input\_lb\_controller\_namespace) | The namespace to deploy the AWS LB Controller into. | `string` | n/a | yes |
| <a name="input_lb_controller_service_account_name"></a> [lb\_controller\_service\_account\_name](#input\_lb\_controller\_service\_account\_name) | The AWS LB Controller Kubernetes service account name. | `string` | n/a | yes |
| <a name="input_lb_controller_version"></a> [lb\_controller\_version](#input\_lb\_controller\_version) | The Helm Chart version of the AWS LB Controller version to install. | `string` | n/a | yes |
| <a name="input_nodegroups"></a> [nodegroups](#input\_nodegroups) | The eks cluster nodegroup configurations | `map(any)` | n/a | yes |
| <a name="input_pod_identity_addon_version"></a> [pod\_identity\_addon\_version](#input\_pod\_identity\_addon\_version) | The version of the EKS pod identity addon. | `string` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | The network CIDRs assigned to private subnets | `map(any)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The name of the project. | `string` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | The network CIDRs assigned to public subnets | `map(any)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy AWS Resources into. | `string` | n/a | yes |
| <a name="input_var.karpenter_service_account_name"></a> [var.karpenter\_service\_account\_name](#input\_var.karpenter\_service\_account\_name) | The name of the Karpenter service account. | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the EKS Cluster VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS control plane. |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | EKS Cluster Name |
| <a name="output_k8s_admin_role_arn"></a> [k8s\_admin\_role\_arn](#output\_k8s\_admin\_role\_arn) | Cluster admin role arn |
| <a name="output_k8s_read_only_role_arn"></a> [k8s\_read\_only\_role\_arn](#output\_k8s\_read\_only\_role\_arn) | Cluster read-only role arn |
| <a name="output_region"></a> [region](#output\_region) | AWS region |
<!-- END_TF_DOCS -->