resource "azurerm_virtual_machine" "web2" {
    name                  = "davidweb2"
    location              = azurerm_resource_group.david-rg.location
    resource_group_name   = azurerm_resource_group.david-rg.name
    availability_set_id   = azurerm_availability_set.avset.id
    network_interface_ids = [azurerm_network_interface.nic2.id]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "myOsDisk2"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }
    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

 os_profile {
        computer_name  = "davidweb2"
        admin_username = "azureuser"
        admin_password = "PassW***"
	custom_data= file("web.sh")
    }

 os_profile_linux_config {
        disable_password_authentication = false
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNm67+KTX/tnFFn57KSYpIjcb8tbRk4YeruTKFrMSKNHb+LbxPp7jBzCJa62nHKqhrrGLsN0o9JgCI92+wYvL1FzP5HCTZN+jQ8JmgYzaRjGtVYBrb0qeqHbT1w64fSWOV8ytNgWkFi+vu1CPjE26HIzCUuNAUVu4lcbQSnsoEt/cQxdYnWnwEYhhhjoYoC+HLqPx0lOFDqtR7fibae8tujHAFxLsUUIxH0qdns747ER6w0s89HkNiF0XmVW2Dt+xswRBfA2ED0o19pON9KGqC75uE8960il+l9FYZvVXoOS8GWKC7c/j0qH8Fq+TaQPH0m+ZGlwVTY/t48gKuMtPf root@user27-admindemo"
        }
    }
    boot_diagnostics {
        enabled     = "true"
        storage_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}

