provider "azurerm" {
  features {}
  subscription_id = "8648d84a-8b3f-437c-adb1-819819ceed83"  
}

# Vytvoření Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "math-token-rg"
  location = "East US"
}

# Vytvoření Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "mathtokenstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Vytvoření Blob Container
resource "azurerm_storage_container" "web" {
  name                  = "web"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}

# Nahrání index.html jako Blob
resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = "${path.module}/web/index.html"
}
