output "app_service_url" {
  description = "URL of the deployed Node.js application"
  value       = "https://${azurerm_app_service.main.default_site_hostname}"
}

