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
  subscription_id = "bea14c12-2f72-4158-a8e0-1b196267677d"

  # features is required
  features {

  }
}
