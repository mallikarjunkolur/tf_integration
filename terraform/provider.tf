terraform { 
  cloud { 
    
    organization = "mallikarjun-org" 

    workspaces { 
      name = "myworkspace" 
    } 
  } 
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}


