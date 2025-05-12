# AKS Service Mesh GitOps Demo – Terraform Codebase

This repository provides a complete Terraform-based codebase for deploying an Azure Kubernetes Service (AKS) cluster integrated with a Service Mesh (Istio) and GitOps (Flux). It automates the provisioning of infrastructure and the deployment of a sample cloud-native application with observability.

## Features and Architecture Overview

- Azure Kubernetes Service (AKS) in Central US region with 3 nodes (Standard_D2s_v3 – 2 vCPU, 8 GiB each), using Managed Identity.
- Istio Service Mesh installed for service-to-service traffic management and security (automatic sidecar injection).
- Observability stack using Prometheus and Grafana (deployed via Helm).
- GitOps with Flux v2 for continuous deployment from a GitHub repository.
- Sample Go application with Dockerfile and Kubernetes manifests using Kustomize.
- Helper scripts for provisioning (`scripts/provision.sh`) and deployment (`scripts/deploy.sh`).
- Documentation including README, design specs, and architecture diagram placeholder.

![Architecture Diagram](docs/architecture.png)

## Repository Structure

```
├── README.md
├── iac/
│   ├── providers.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── network.tf
│   ├── acr.tf
│   ├── flux.tf
│   ├── helm.tf
│   └── outputs.tf
├── manifests/
│   ├── base/
│   │   ├── namespace.yaml
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── dev/
│           ├── kustomization.yaml
│           └── deployment-patch.yaml
├── app/
│   ├── main.go
│   ├── Dockerfile
│   └── go.mod
├── scripts/
│   ├── provision.sh
│   └── deploy.sh
└── docs/
    ├── design-specifications.md
    └── architecture.png
```

## Prerequisites

- Azure Subscription
- Azure CLI (logged in)
- Terraform >= 1.3.0
- Kubectl
- Helm
- Git
- Docker

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/your-username/aks-service-mesh-gitops-demo.git
cd aks-service-mesh-gitops-demo
```

### Configure Variables

Edit `iac/variables.tf` or create `iac/terraform.tfvars`:

```hcl
gitops_repo_url    = "https://github.com/<youraccount>/<yourrepo>.git"
gitops_repo_branch = "main"
```

### Provision Infrastructure

```bash
bash scripts/provision.sh
```

### Deploy the Application

```bash
bash scripts/deploy.sh
```

### Verify Deployment

```bash
az aks get-credentials -g rg-aksmeshdemo-cus -n aks-aksmeshdemo-cus
kubectl get nodes
kubectl get pods -n demo
kubectl port-forward svc/demo-app -n demo 8080:80
curl http://localhost:8080
```

### Access Grafana

```bash
kubectl get svc -n monitoring kube-prometheus-stack-grafana
```

Login with admin / admin.

## Cleanup

```bash
cd iac
terraform destroy -auto-approve
```

## Contributing

Fork the repo, create a feature branch, commit, push, and open a PR.

## License

MIT License.

## Acknowledgments

- Microsoft Azure Documentation: AKS
- Istio Documentation
- Flux Documentation
- Prometheus Community
- Grafana
