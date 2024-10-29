resource "azurerm_resource_group" "twrg" { # alias name only for terraform!
  name     = var.azure_rg_name
  location = var.azure_location

  tags = {
    source = "terraform"
  }
}
