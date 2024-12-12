provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "math-token-rg"
  location = "East US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "mathtokenstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "web" {
  name                  = "web"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = "${path.module}/web/index.html"
}
