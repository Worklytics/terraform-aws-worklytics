# TODO modules referenced by relative path until published in registry, or in a public repo

# create the resources needed to auth with the Worklytics Tenant API
module "tenant_api_auth" {
  source = "../../modules/cognito_tenant_api_auth"

  resource_name_prefix = var.resource_name_prefix
  worklytics_tenant_id = var.worklytics_tenant_id
  user_principal_email = var.user_principal_email
}

# create script files for each Psoxy connection
module "create_psoxy_connection_script" {
  source = "../../modules/psoxy_connection"

  for_each = {
    for psoxy_connection in var.psoxy_connections:
    psoxy_connection.integration => psoxy_connection
  }
  psoxy_connection = {
    integration = each.value.integration
    kind        = each.value.kind
    endpoint    = each.value.endpoint
    region      = each.value.region
    role_arn    = each.value.role_arn
  }
  psoxy_connection_script_path = path.module
  identity_pool_id             = module.tenant_api_auth.worklytics_identity_pool_id
  identity_pool_region         = module.tenant_api_auth.worklytics_identity_pool_region
  identity_pool_user_principal = module.tenant_api_auth.worklytics_identity_pool_user_principal
  worklytics_tenant_id         = var.worklytics_tenant_id
}