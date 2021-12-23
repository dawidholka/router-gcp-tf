output "app_key_secret_id" {
  value = module.app_key.secret_id
}

output "database_database_secret_id" {
  value = module.database_database.secret_id
}

output "database_username_secret_id" {
  value = module.database_username.secret_id
}

output "database_password_secret_id" {
  value = module.database_password.secret_id
}