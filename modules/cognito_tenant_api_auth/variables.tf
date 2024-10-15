variable "resource_name_prefix" {
  type        = string
  description = "Prefix to give to names of infra created by this module, where applicable."
  default     = "worklytics-tenant-api-"
}

variable "worklytics_tenant_id" {
  type        = string
  description = "Numeric ID of your Worklytics tenant's service account (obtain from Worklytics Web App)."

  validation {
    condition     = var.worklytics_tenant_id == null || can(regex("^\\d{21}$", var.worklytics_tenant_id))
    error_message = "`worklytics_tenant_id` must be a 21-digit numeric value. (or `null`, for pre-production use case where you don't want external entity to be allowed to assume the role)."
  }
}

# This will appear in the AWS console (Amazon Cognito > Identity Pools > Identity Pool Name) as a "Linked login" in
# identity browser of the pool. In development, don't use `localhost:8080` as this is used as the value for
# `developer_provider_name` pool which is subject to some restrictions: only alphanumeric characters, dots, underscores
# and hyphens
variable "tenant_api_host" {
  type        = string
  description = "Host of the Worklytics Tenant API: the domain by which Cognito will refer users."
  default     = "intl.worklytics.co"
}

variable "region" {
  type        = string
  description = "The AWS region where Cognito Identity Pool is created."
  default     = "us-east-1"
}

variable "user_principal_email" {
  type        = string
  description = "The email of the user that has been granted access to the Worklytics Tenant API (configure in Worklytics Web App)."
}
