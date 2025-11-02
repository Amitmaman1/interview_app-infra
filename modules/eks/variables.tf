variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "killer-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.29"
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public access to EKS API endpoint"
  type        = bool
  default     = true
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Enable cluster creator admin permissions"
  type        = bool
  default     = true
}

# Node Group Configuration
variable "node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
  default     = "example"
}

variable "ami_type" {
  description = "AMI type for EKS managed node groups"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "instance_types" {
  description = "Instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.small"]
}

variable "min_size" {
  description = "Minimum size of the node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum size of the node group"
  type        = number
  default     = 4
}

variable "desired_size" {
  description = "Desired size of the node group"
  type        = number
  default     = 2
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS cluster will be created"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}