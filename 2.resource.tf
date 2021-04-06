resource "azurerm_resource_group" "david-rg" {
    name     = var.resource_group
    location = var.demo_region

    tags = {
        environment = "Terraform Demo"
    }
}
