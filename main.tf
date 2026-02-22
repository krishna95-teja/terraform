terraform {
 backend "azurerm" {
  resource_group_name = "rg-tf-backend"
  storage_account_name = "sttfbackend1"
  container_name = "tfstate"
  key = "dev.terraform.tfstate"       # Path to the statefile is sttfbackend1/tfstate/dev.terraform.tfstate
  use_azuread_auth = true
  }
 }
resource "azurerm_resource_group" "demo" {
 name = "rg-demo-dev-update"
 location = "Central India"
}
resource "azurerm_virtual_network" "vnet" {
	name = "vnet-one"
	location = azurerm_resource_group.demo.location
	resource_group_name = azurerm_resource_group.demo.name
	address_space = ["10.0.0.0/16"]
	subnet {
		name = "subnet1"
		address_prefixes = ["10.0.1.0/24"]
	}
}

resource "azurerm_public_ip" "pubip" {
	name = "public-ip-name-demo"
	resource_group_name = azurerm_resource_group.demo.name
	location = azurerm_resource_group.demo.location
	allocation_method = "Static"
}

resource "azurerm_network_interface" "nic" {
	name = "nic-name-demo-one"
    location = azurerm_resource_group.demo.location
	resource_group_name = azurerm_resource_group.demo.name
}


resource "azurerm_virtual_machine" "vm-demo" {
 name = "vm-demo-one"
 location = azurerm_resource_group.demo.location
 resource_group_name = azurerm_resource_group.demo.name
 size = "Standard_B1s"
	source_image_reference {
		publisher = "Canonical"
    		offer     = "0001-com-ubuntu-server-jammy"
    		sku       = "22_04-lts"
    		version   = "latest"
	}
admin_ssh_key {
 username = "adminuser"
 public_key = file("~/.ssh/id_rsa.pub")
   }
  } 
