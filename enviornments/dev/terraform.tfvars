vpc_name           = "killer-vpc"
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
enable_nat_gateway = true
cluster_name = "killer-cluster"
kubernetes_version                         = "1.30"
enable_irsa                                = true
endpoint_public_access                     = true
enable_cluster_creator_admin_permissions   = true

node_group_name      = "my-nodes"
ami_type             = "AL2023_x86_64_STANDARD"
instance_types       = ["t3.medium"]
min_size             = 1
max_size             = 4
desired_size         = 2

alb_controller_version = "1.8.1"

external_secrets_version        = "0.10.5"
external_secrets_namespace      = "external-secrets"

argocd_version              = "7.3.0"
argocd_namespace            = "argocd"
argocd_insecure             = true
argocd_service_type         = "LoadBalancer"
argocd_controller_replicas  = 1



common_tags = {
  Environment = "dev"
  Terraform   = "true"
  ManagedBy   = "Terraform"
}

