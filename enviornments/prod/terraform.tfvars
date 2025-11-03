vpc_name           = "killer-vpc-prod"
vpc_cidr           = "10.1.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets    = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
public_subnets     = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
enable_nat_gateway = true
cluster_name = "killer-cluster-prod"
kubernetes_version                         = "1.30"
enable_irsa                                = true
endpoint_public_access                     = true
enable_cluster_creator_admin_permissions   = true

node_group_name      = "prod-nodes"
ami_type             = "AL2023_x86_64_STANDARD"
instance_types       = ["t3.large"]
min_size             = 3
max_size             = 10
desired_size         = 3

alb_controller_version = "1.8.1"

external_secrets_version        = "0.10.5"
external_secrets_namespace      = "external-secrets"

argocd_version              = "7.3.0"
argocd_namespace            = "argocd"
argocd_insecure             = false
argocd_service_type         = "LoadBalancer"
argocd_controller_replicas  = 2



common_tags = {
  Environment = "prod"
  Terraform   = "true"
  ManagedBy   = "Terraform"
}


