# Create Psoxy Connections Example

This example illustrates how to create Psoxy connections in Worklytics via its Tenant API.

Assuming you've set up a Psoxy instance in AWS, the example will create an AWS Cognito Identity Pool to authenticate
with the Tenant API, and a shell script that creates a Psoxy Connection for each one of the Data Sources configured in 
your Psoxy instance.

Terraform variables used:

```hcl
worklytics_tenant_id = "116863361842113328137"
user_principal_email = "johndoe@acme.com"
psoxy_connections = [{
  integration = "data-source-psoxy",
  kind = "aws",
  endpoint = "https://acme.execute-api.us-east-1.amazonaws.com/data-source-psoxy/",
  region = "us-east-1",
  role_arn = "psoxy::caller::arn"
}]
```

- `worklytics_tenant_id` is the unique ID of your Worklytics tenant.
- `user_principal_email` is the email of the user principal that will be used to authenticate with the Tenant API, and
  must be registered as `DataConnectionAdmin` via the Worklytics Web App.
- `psoxy_connections` is a collection of the attributes for each Data Source configured in your Psoxy instance.
