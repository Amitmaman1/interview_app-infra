resource "helm_release" "argocd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_version

  namespace        = var.argocd_namespace
  create_namespace = true

  values = [
    yamlencode({
      configs = {
        params = {
          "server.insecure" = var.argocd_insecure 
        }
      }

      server = {
        service = {
          type = var.argocd_service_type 
          annotations = {
            "service.beta.kubernetes.io/aws-load-balancer-type" = "external"
            "service.beta.kubernetes.io/aws-load-balancer-scheme" = "internet-facing"
          }
        }
      }

      controller = {
        replicas = var.argocd_controller_replicas
      }
    })
  ]

  depends_on = []
}
