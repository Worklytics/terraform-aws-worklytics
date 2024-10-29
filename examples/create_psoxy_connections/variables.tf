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

variable "psoxy_connections" {
  type = list(object({
    integration         = string           # The integration ID to use for this connection.
    region              = string           # The AWS region of the Proxy instance.
    role_arn            = string           # The ARN role to invoke the Proxy instance.
    endpoint            = optional(string) # The endpoint of the lambda function (Work Data connections use-case).
    bucket              = optional(string) # The S3 bucket (Bulk Data connections use-case).
    parser_id           = optional(string) # Bulk Data connections only.
    github_organization = optional(string) # GitHub Connections only.
  }))
  description = "The connection details for Psoxy connections to be created via Worklytics Tenant API."
}

variable "psoxy_connection_script_path" {
  type        = string
  description = "Where to create the script to create the Psoxy connection"
}