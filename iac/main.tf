resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-${var.project_name}-cus"
  location = var.location
  tags = {
    environment = "demo"
    project     = var.project_name
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.project_name}acr"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project_name}-cus"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${var.project_name}-aks"

  default_node_pool {
    name            = "nodepool"
    node_count      = var.node_count
    vm_size         = var.node_vm_size
    os_disk_size_gb = 50
    type            = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  role_based_access_control {
    enabled = true
  }

  tags = azurerm_resource_group.aks_rg.tags
}
