variable "project_name" {
  description = "Project name for naming resources"
  type        = string
  default     = "aksmeshdemo"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "centralus"
}

variable "node_count" {
  description = "Number of AKS worker nodes"
  type        = number
  default     = 3
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "gitops_repo_url" {
  description = "GitHub repository URL for Flux"
  type        = string
  default     = ""
}

variable "gitops_repo_branch" {
  description = "Git branch for Flux"
  type        = string
  default     = "main"
}

variable "gitops_repo_path" {
  description = "Path in repo for Kubernetes manifests"
  type        = string
  default     = "manifests/overlays/dev"
}
