resource "azurerm_log_analytics_workspace" "suong-assignment2" {
  name                = "suong-assignment2"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "PerGB2018"
  retention_in_days   = 30
 tags                  = local.common_tags

}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "default"
  location            = var.location
  resource_group_name = var.rg
  sku                 = "Standard"

  soft_delete_enabled = true
}

resource "azurerm_storage_account" "storage_acc" {
  name                     = "storageacc3552"
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "container-3552"
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "stor_blob" {
  name                   = "stor_blob-3552"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
}
