module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  addons = {
    coredns                 = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy              = {}
    vpc-cni                 = {
      before_compute = true
    }
  }
  enable_irsa = var.enable_irsa

  endpoint_public_access = var.endpoint_public_access

  
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

 
  vpc_id = module.vpc.vpc_id
  
  
  subnet_ids = module.vpc.private_subnets 
  
  
  eks_managed_node_groups = {
    (var.node_group_name) = {
      
      ami_type       = var.ami_type
      instance_types = var.instance_types

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
    }
  }

  tags = var.common_tags
  
}