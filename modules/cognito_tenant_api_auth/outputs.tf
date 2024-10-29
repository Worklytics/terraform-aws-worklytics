output "worklytics_identity_pool_id" {
  value = aws_cognito_identity_pool.worklytics_identity_pool.id
}

output "worklytics_identity_pool_arn" {
  value = aws_cognito_identity_pool.worklytics_identity_pool.arn
}

output "worklytics_identity_pool_region" {
  value = var.region
}

output "worklytics_identity_pool_user_principal" {
  value = var.user_principal_email
}
