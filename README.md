# Infrastructure as Code

Terraform configs for spinning up the entire AWS infrastructure - EKS cluster, VPC, monitoring, and all the Kubernetes add-ons.

## What's in here

```
infra/
├── modules/
│   ├── vpc/                  # VPC, subnets, NAT gateways
│   ├── eks/                  # EKS cluster + node groups
│   ├── monitoring/           # Prometheus + Grafana stack
│   └── add-on/
│       ├── argocd/          # GitOps controller
│       ├── alb-controller/  # AWS Load Balancer Controller
│       └── external-secret/ # External Secrets Operator
└── enviornments/
    ├── dev/
    ├── stage/
    └── prod/
```

## What it builds

- **VPC**: Multi-AZ setup with public/private subnets
- **EKS**: Managed Kubernetes cluster with auto-scaling nodes
- **Monitoring**: Prometheus + Grafana with custom dashboards
- **ArgoCD**: For GitOps deployments
- **ALB Controller**: Manages AWS load balancers for ingress
- **External Secrets**: Syncs secrets from AWS Secrets Manager to K8s

## Usage

```bash
cd enviornments/dev
terraform init
terraform plan
terraform apply
```

After applying, update your kubeconfig:
```bash
aws eks update-kubeconfig --name killer-cluster --region us-east-1
```

## Accessing Services

**ArgoCD**:
```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

**Grafana**:
```bash
kubectl get secret -n monitoring kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d
kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 3000:80
```

## Environment Differences

| | Dev | Stage | Prod |
|---|---|---|---|
| **VPC CIDR** | 10.0.0.0/16 | 10.2.0.0/16 | 10.1.0.0/16 |
| **Instance Type** | t3.medium | t3.medium | t3.large |
| **Nodes (min/max)** | 2/4 | 2/6 | 3/10 |
| **AZs** | 2 | 2 | 3 |
| **ArgoCD TLS** | disabled | disabled | enabled |

## Monitoring

Prometheus comes pre-configured with alerts for:
- High CPU/memory usage
- Pod restarts
- Node pressure
- PVC usage

Alert notifications go to Gmail (configured in monitoring module).

## Security

- IRSA for pod-level AWS permissions (no static credentials)
- External Secrets Operator pulls secrets from AWS Secrets Manager
- Private subnets for worker nodes
- No secrets in Git

## Related Repos

This infrastructure hosts:
- **Application**: [interview_app](https://github.com/Amitmaman1/interview_app) - The actual application code
- **GitOps**: [interview_app-gitops](https://github.com/Amitmaman1/interview_app-gitops) - ArgoCD deployment configs

## Cleanup

```bash
cd enviornments/<env>
terraform destroy
```

**Warning**: This deletes everything including persistent data.
