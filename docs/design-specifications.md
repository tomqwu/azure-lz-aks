# Design Specifications

This document provides detailed design considerations and architecture for the AKS Service Mesh GitOps Demo.

## Naming Conventions

- Resource Group: `rg-<project_name>-cus`
- AKS Cluster: `aks-<project_name>-cus`
- ACR: `<project_name>acr`
- Other resources follow `<type>-<project_name>-<region>` pattern.

## Identity and Access

- AKS uses a system-assigned managed identity.
- The identity is granted `AcrPull` role on the ACR for image pull.

## Service Mesh

- Istio installed via Helm in `istio-system`.
- Sidecar injection enabled with the label `istio-injection=enabled`.

## Observability

- Prometheus + Grafana installed via kube-prometheus-stack.
- Grafana exposed via LoadBalancer (demo only).
- Default admin password: `admin`.

## GitOps

- Flux v2 installed via AKS extension.
- Monitors Git repo URL and branch for `manifests/overlays/dev`.
- Sync interval: 60 seconds.

## Application

- Sample Go web server.
- Multi-stage Dockerfile for small runtime image.
- Managed with Kustomize (base + overlay).

## Scripts

- `provision.sh`: Terraform init & apply.
- `deploy.sh`: Build & push Docker image to ACR.
