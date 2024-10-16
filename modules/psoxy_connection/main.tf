
locals {
  psoxy_connection_script_path     = "${coalesce(var.psoxy_connection_script_path, path.module)}/"
  psoxy_connection_script_filename = coalesce(var.psoxy_connection_script_filename, "create_${var.psoxy_connection.integration}_connection.sh")
}

resource "local_file" "worklytics_tenant_api_script_file" {
  content         = <<EOT
#!/bin/bash

# Script to set up a Psoxy connection for ${var.psoxy_connection.integration}

TOKEN=`aws cognito-identity get-open-id-token-for-developer-identity \
  --identity-pool-id ${var.identity_pool_id} \
  --logins ${var.tenant_api_host}=${var.identity_pool_user_principal} \
  --region ${var.identity_pool_region} \
  | jq -r '.Token'`

curl -X POST https://${var.tenant_api_host}/tenant/data-connections \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-worklytics-tenant-id: ${var.worklytics_tenant_id}"\
  -H "Content-Type: application/json" \
  -d '{
       "integrationId": "${var.psoxy_connection.integration}",
        "settings": {
          "PROXY_DEPLOYMENT_KIND": "AWS",
          "PROXY_ENDPOINT": "${var.psoxy_connection.endpoint}",
          "PROXY_AWS_REGION": "${var.psoxy_connection.region}",
          "PROXY_AWS_ROLE_ARN": "${var.psoxy_connection.role_arn}"
          ${var.psoxy_connection.parser_id != null ? ", \"parserId\": \"${var.psoxy_connection.parser_id}\"" : ""}
          ${var.psoxy_connection.github_organization != null ? ", \"github_organization\": \"${var.psoxy_connection.github_organization}\"" : ""}
        }
     }'
EOT
  filename        = "${local.psoxy_connection_script_path}${local.psoxy_connection_script_filename}"
  file_permission = "0755"
}
