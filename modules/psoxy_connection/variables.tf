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
  description = "Host of the Worklytics Tenant API"
  default     = "intl.worklytics.co"
}

variable "identity_pool_id" {
  type        = string
  description = "The ID of the Cognito Identity Pool to use for authentication with the Worklytics Tenant API."
}

variable "identity_pool_user_principal" {
  type        = string
  description = "The user principal that has been granted access to the Worklytics Tenant API."
}

variable "identity_pool_region" {
  type        = string
  description = "The region of the Cognito Identity Pool to use for authentication with the Worklytics Tenant API."
}

variable "psoxy_connection" {
  type = object({
    integration         = string           # The integration ID to use for this connection.
    region              = string           # The AWS region of the Proxy instance.
    role_arn            = string           # The ARN role to invoke the Proxy instance.
    endpoint            = optional(string) # The endpoint of the lambda function (Work Data connections use-case).
    bucket              = optional(string) # The S3 bucket (Bulk Data connections use-case).
    parser_id           = optional(string) # Bulk Data connections only.
    github_organization = optional(string) # GitHub Connections only.
  })
  description = "The connection details for a Psoxy connection to be created via Worklytics Tenant API."
}

variable "psoxy_connection_script_path" {
  type        = string
  description = "Path where script to create the Psoxy connection will be placed."
}

variable "psoxy_connection_script_filename" {
  type        = string
  description = "Name of the script file to create the Psoxy connection."
  default     = "create_psoxy_connection.sh"
}