variable "environment" {
  description = "The project nvironment."
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

variable "repository_name" {
  description = "The name of ECR Repository."
  type        = string
}

variable "enable_immutable_tags" {
  description = "Set to True to enable immutable tags."
  type        = bool
}

variable "enable_scan_on_push" {
  description = "Enable image scanning in ECR."
  type        = bool
}