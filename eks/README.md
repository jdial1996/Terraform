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
