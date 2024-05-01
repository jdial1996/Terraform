variable "environment" {
  description = "The project nvironment."
  type        = string
}

variable "project" {
  description = "The name of the project."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the EKS Cluster VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  type = map(any)
  default = {
    eu-west-2a : "10.0.101.0/24",
    eu-west-2b : "10.0.102.0/24",
    eu-west-2c : "10.0.103.0/24"
  }
}

variable "private_subnet_cidrs" {
  type = map(any)
  default = {
    eu-west-2a : "10.0.104.0/24",
    eu-west-2b : "10.0.105.0/24",
    eu-west-2c : "10.0.106.0/24"
  }
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

variable "max_nodes" {
  description = "The maximum number of nodes in the default nodegroup"
  type        = number
}

variable "min_nodes" {
  description = "The minimum number of nodes in the default nodegroup"
  type        = number
}

variable "desired_nodes" {
  description = "The desired number of nodes in the default nodegroup"
  type        = number
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

