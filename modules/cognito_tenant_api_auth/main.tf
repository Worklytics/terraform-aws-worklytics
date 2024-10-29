terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_cognito_identity_pool" "worklytics_identity_pool" {
  identity_pool_name               = "${var.resource_name_prefix}identity-pool"
  allow_unauthenticated_identities = false
  allow_classic_flow               = false
  developer_provider_name          = var.tenant_api_host
}

resource "aws_iam_policy" "cognito_developer_identities" {
  name        = "${aws_cognito_identity_pool.worklytics_identity_pool.identity_pool_name}_CognitoDeveloperIdentityForWorklyticsTerraform"
  description = "Allow principal to read and lookup developer identities from Cognito Identity: ${aws_cognito_identity_pool.worklytics_identity_pool.id}"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "cognito-identity:GetOpenIdTokenForDeveloperIdentity",
          ],
          "Effect" : "Allow",
          "Resource" : aws_cognito_identity_pool.worklytics_identity_pool.arn
        }
      ]
  })
}
