module "vpc" {
  source = "../../modules/vpc"

  vpc_name                 = var.vpc_name
  vpc_cidr                 = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = var.enable_nat_gateway
  common_tags          = var.common_tags
}


module "eks" {
  source                  = "../../modules/eks"
  cluster_name            = var.cluster_name
  kubernetes_version      = var.kubernetes_version
  enable_irsa             = var.enable_irsa
  endpoint_public_access  = var.endpoint_public_access
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnets
  
  node_group_name         = var.node_group_name
  ami_type                = var.ami_type
  instance_types          = var.instance_types
  min_size                = var.min_size
  max_size                = var.max_size
  desired_size            = var.desired_size
  
  common_tags             = var.common_tags
}

module "eso-irsa" {
  source         = "../../modules/add-on/eso-irsa"
  oidc_provider_arn = module.eks.oidc_provider_arn
  common_tags    = var.common_tags
  depends_on     = [module.eks]
}



module "alb_controller" {
  source                  = "../../modules/add-on/alb-controller"
  cluster_name            = module.eks.cluster_name
  oidc_provider_arn       = module.eks.oidc_provider_arn
  vpc_id                  = module.vpc.vpc_id
  alb_controller_version  = var.alb_controller_version
  common_tags             = var.common_tags
  depends_on              = [module.eks]
}

module "external_secrets" {
  source                     = "../../modules/add-on/external-secret"
  external_secrets_version    = var.external_secrets_version
  external_secrets_namespace  = var.external_secrets_namespace
  external_secrets_role_arn   = module.eso-irsa.external_secrets_role_arn
  common_tags                = var.common_tags
  depends_on                 = [module.eks, module.eso-irsa]
}

module "argocd" {
  source                   = "../../modules/add-on/argocd"
  argocd_version           = var.argocd_version
  argocd_namespace         = var.argocd_namespace
  argocd_insecure          = var.argocd_insecure
  argocd_service_type      = var.argocd_service_type
  argocd_controller_replicas = var.argocd_controller_replicas
  cluster_name             = module.eks.cluster_name
  common_tags              = var.common_tags
  depends_on               = [module.eks]
}

module "monitoring" {
  source      = "../../modules/monitoring"
  aws_region  = var.aws_region
  common_tags = var.common_tags
  depends_on  = [module.eks, module.external_secrets]
}


