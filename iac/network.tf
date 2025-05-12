# network.tf
# (Optional) Custom virtual network and subnet definitions for AKS.

# Example:
# resource "azurerm_virtual_network" "vnet" {
#   name                = "${var.project_name}-vnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = var.location
#   resource_group_name = azurerm_resource_group.aks_rg.name
# }
#
# resource "azurerm_subnet" "aks_subnet" {
#   name                 = "${var.project_name}-subnet"
#   resource_group_name  = azurerm_resource_group.aks_rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.1.0/24"]
# }
#
# Then reference the subnet in the AKS resource_profile.vnet_subnet_id
