# https://developer.hashicorp.com/terraform/language/backend

terraform {
  backend "azurerm" {
    resource_group_name  = "AI-challenge"
    storage_account_name = "rikesstorage"
    container_name       = "tf-playground"
    key                  = "terraform.tfstate" # name of state file
  }
}
