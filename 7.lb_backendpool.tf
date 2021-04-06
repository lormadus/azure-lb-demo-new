resource "azurerm_lb_backend_address_pool" "david-bpepool" {
    resource_group_name = azurerm_resource_group.david-rg.name
    loadbalancer_id = azurerm_lb.david-lb.id
    name = "david-BackEndAddressPool"
}
