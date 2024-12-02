resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku_name            = "F1"  # Free Tier (no capacity setting required here)
  os_type             = "Linux"  # Or "Windows" depending on your app's requirements
}

resource "azurerm_app_service" "main" {
  name                = var.app_service_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_service_plan.main.id

  site_config {
    node_version = "16-lts"  # Set the Node.js version for your app
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = var.app_package_url  # Deployment package URL
    "NODE_ENV" = "production"  # Set environment to production
    # Add other environment variables required by your app
    "MY_CUSTOM_VARIABLE" = "my-value"
  }
}
