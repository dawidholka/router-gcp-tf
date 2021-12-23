module "app_key" {
  source = "./single-secret"

  name  = "app_key"
  value = var.app_key
}

module "database_database" {
  source = "./single-secret"

  name  = "database_database"
  value = var.database_database
}

module "database_username" {
  source = "./single-secret"

  name  = "database_username"
  value = var.database_username
}

module "database_password" {
  source = "./single-secret"

  name  = "database_password"
  value = var.database_password
}
