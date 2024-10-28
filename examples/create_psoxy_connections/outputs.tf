output "worklytics_tenant_api_identity_pool_user_principal" {
  value = module.tenant_api_auth.worklytics_identity_pool_user_principal
}

output "worklytics_tenant_api_scripts" {
  value = { for key, value in module.create_psoxy_connection_script : key => value.worklytics_tenant_api_script_file.filename }
}