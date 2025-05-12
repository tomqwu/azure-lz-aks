resource "azurerm_kubernetes_cluster_extension" "flux" {
  name             = "flux"
  extension_type   = "microsoft.flux"
  cluster_id       = azurerm_kubernetes_cluster.aks.id
  target_namespace = "flux-system"
  depends_on       = [azurerm_kubernetes_cluster.aks]
}

resource "azurerm_kubernetes_flux_configuration" "flux_config" {
  name       = "flux-system"
  cluster_id = azurerm_kubernetes_cluster.aks.id
  namespace  = "flux-system"

  git_repository {
    url            = var.gitops_repo_url
    reference_type = "branch"
    reference      = var.gitops_repo_branch
  }

  kustomization {
    name                    = "demo-app"
    path                    = var.gitops_repo_path
    timeout_in_seconds      = 300
    sync_interval_in_seconds = 60
  }

  scope      = "cluster"
  depends_on = [azurerm_kubernetes_cluster_extension.flux]
}
