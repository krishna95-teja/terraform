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
 location = "South India"
}
