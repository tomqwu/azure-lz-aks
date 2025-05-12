resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  depends_on           = [
    azurerm_kubernetes_cluster.aks,
    azurerm_container_registry.acr
  ]
}
