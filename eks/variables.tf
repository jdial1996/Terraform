## Project

variable "environment" {
  description = "The project environment."
  type        = string
}

variable "project" {
  description = "The name of the project."
  type        = string
}

variable "region" {
  description = "The region to deploy AWS Resources into."
  type        = string
}
## Network

variable "vpc_cidr" {
  description = "The CIDR block for the EKS Cluster VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  type        = map(any)
  description = "The network CIDRs assigned to public subnets"
}

variable "private_subnet_cidrs" {
  type        = map(any)
  description = "The network CIDRs assigned to private subnets"
}

variable "enable_dns_hostnames" {
  description = "Allocate public hostname for instances with IPv4"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enables DNS resolution of hostnames within the VPC."
  type        = bool
  default     = true
}

variable "enable_endpoint_private_access" {
  description = "Enables DNS resolution of hostnames within the VPC."
  type        = bool
}

## Cluster

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The underlying version of Kubernetes for EKS"
  type        = string
}

variable "cluster_log_types" {
  description = "The desired controlplane logging to enable.  Valid values: api | audit | authenticator | scheduler | controller-manager"
  type        = list(string)
}

variable "cluster_authentication_mode" {
  description = "The cluster authentication mode for IAM principles."
  type        = string
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Enable automatic grant of cluster-admin-creator to IAM entity that created the cluster"
  type        = bool
}

variable "enable_managed_nodegroups" {
  description = "Feature switch for managed nodegroups"
  type        = bool
}

variable "nodegroups" {
  description = "The eks cluster nodegroup configurations"
  type        = map(any)
}

variable "enable_eks_fargate_profiles" {
  description = "Feature switch for managed nodegroups"
  type        = bool
}

variable "eks_fargate_profiles" {
  description = "The eks cluster nodegroup configurations"
  type        = map(any)
}


### RBAC 

variable "create_read_only_user" {
  description = "Create an EKS read only user."
  type        = bool
}

variable "create_cluster_admin_user" {
  description = "Create an EKS cluster admin user."
  type        = bool
}

## AWS LB Controller


variable "create_lb_controller" {
  description = "Create AWS LB Controller for EKS."
  type        = bool
}

variable "lb_controller_namespace" {
  description = "The namespace to deploy the AWS LB Controller into."
  type        = string
}

variable "lb_controller_service_account_name" {
  description = "The AWS LB Controller Kubernetes service account name."
  type        = string
}


variable "lb_controller_version" {
  description = "The Helm Chart version of the AWS LB Controller version to install."
  type        = string
}

## AWS Container Insights

variable "enable_container_insights" {
  description = "Feature switch for Container Insights"
  type        = bool
}

variable "cloudwatch_agent_namespace" {
  description = "The namespace to deploy the Cloudwatch Agent in."
  type        = bool
}

variable "cloudwatch_agent_service_account_name" {
  description = "The  CloudWatch Agent Kubernetes service account name."
  type        = string
}

#EKS Addons 

variable "pod_identity_addon_version" {
  description = "The version of the EKS pod identity addon."
  type        = string
<<<<<<< Updated upstream
=======
}

variable "enable_ebs_csi_controller" {
  description = "Feature switch for EBS CSI Controller"
  type        = bool
}

variable "ebs_csi_driver_addon_version" {
  description = "The version of the EBS CSI Controller addon."
  type        = string
  default = null 
}

variable "enable_kubecost_addon" {
  description = "Feature switch for Kubecost addon."
  type        = bool
}

variable "kubecost_addon_version" {
  description = "The version of the Kubecost addon."
  type        = string
  default = null 
>>>>>>> Stashed changes
}