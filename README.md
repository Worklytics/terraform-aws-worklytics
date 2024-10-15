# Terraform AWS Worklytics 

A collection of Terraform submodules to support the Worklytics Tenant API using Amazon Web Services (AWS) resources.

- [Tenant API: authentication via AWS Cognito](modules/cognito_tenant_api_auth)
- [Tenant API: create a Psoxy Connection](modules/psoxy_connection)

The main use-case for these submodules is to create [Psoxy Connections] in Worklytics via its [Tenant API]. 

After a successful Psoxy deployment (Data Source fully configured, Psoxy instance tested and running), the last step
should be to create the actual connection in the [Data Sources] section of the Worklytics Web App. These submodules
provide a way to automate this process.

See the [examples/create_psoxy_connections] for a complete usage example.

[Psoxy Connections]: https://docs.worklytics.co/psoxy
[Tenant API]: https://docs.worklytics.co/knowledge-base/tenant-api
[Data Sources]: https://app.worklytics.co/analytics/data-sources
[examples/create_psoxy_connections]: examples/create_psoxy_connections