# Provider Configuration
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# VPC Configuration
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

# EKS Configuration
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
  default     = 3
}


# ALB Controller Configuration
variable "alb_controller_version" {
  description = "Version of AWS Load Balancer Controller"
  type        = string
  default     = "1.8.1"
}

# ArgoCD Configuration
variable "argocd_version" {
  description = "Version of ArgoCD"
  type        = string
  default     = "7.3.0"
}

variable "argocd_namespace" {
  description = "Namespace for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "argocd_insecure" {
  description = "Disable internal TLS for ArgoCD server"
  type        = bool
  default     = true
}

variable "argocd_service_type" {
  description = "Service type for ArgoCD server"
  type        = string
  default     = "LoadBalancer"
}

variable "argocd_controller_replicas" {
  description = "Number of ArgoCD controller replicas"
  type        = number
  default     = 1
}


variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "external_secrets_version" {
  description = "Version of External Secrets Operator"
  type        = string
  default     = "v0.9.20"
}

variable "external_secrets_namespace" {
  description = "Namespace for External Secrets Operator"
  type        = string
  default     = "external-secrets"
}

