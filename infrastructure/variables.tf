variable "resource_group_name" {
  default = "nodejs-app-resource-group"  # Name of your resource group
}

variable "location" {
  default = "East US"  # Azure region
}

variable "app_service_plan_name" {
  default = "nodejs-app-service-plan"  # App Service Plan name
}

variable "app_service_name" {
  default = "nodejs-web-app"  # App Service name
}

variable "app_package_url" {
  description = "URL of the deployment package (.zip)"
  default     = "https://github.com/IR0NBYTE/Devops/blob/main/nodejs-app.zip"  # Update with your package URL
}

