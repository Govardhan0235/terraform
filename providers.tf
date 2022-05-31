terraform {



  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.8.0"
    }
  }
}

provider "azurerm" {
  subscription_id      = "e3555fbc-651c-4aca-9059-3a80891ad408"
  client_id            = "cdf8c195-5b73-431e-a6ed-9a935cdffdfb"
  client_secret        = "vSG8Q~5OYCqfgnDr6efMVLa83AILd7Phe7UPuau7"

  tenant_id            = "75f2a99b-01fd-48f2-ac60-d4a7a44fd0cc"
  features {}
}
