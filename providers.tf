terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.7.0" # also possible e.g. ~>4.7
      # if a new version should be used, the lock file must be removed
    }
  }
}

provider "azurerm" {
  # Configuration options

  # features is required
  features {

  }
}
