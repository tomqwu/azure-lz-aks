output "resource_group_name" {
  value       = azurerm_resource_group.aks_rg.name
  description = "The name of the resource group"
}

output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "The ACR login server"
}

output "flux_git_repo_url" {
  value       = var.gitops_repo_url
  description = "Git repository URL for Flux"
}
