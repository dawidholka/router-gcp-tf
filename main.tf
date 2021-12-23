module "docker" {
  source = "./modules/docker"

  gcp_project = var.gcp_project
  image_tag   = var.image_tag
}

module "database" {
  source = "./modules/database"

  database_password = var.database_password
}

module "migrate" {
  count  = var.migrate_database ? 1 : 0
  source = "./modules/database-migrate"

  app_key           = var.app_key
  image_tag         = var.image_tag
  database_database = module.database.database
  database_host     = module.database.database_host
  database_password = module.database.password
  database_username = module.database.username
}

module "secrets" {
  source = "./modules/secrets"

  app_key           = var.app_key
  database_database = module.database.database
  database_password = module.database.password
  database_username = module.database.username
}

module "router" {
  source = "./modules/router"

  container_image             = module.docker.container_image
  app_key_secret_id           = module.secrets.app_key_secret_id
  database_database_secret_id = module.secrets.database_database_secret_id
  database_password_secret_id = module.secrets.database_password_secret_id
  database_username_secret_id = module.secrets.database_username_secret_id
  cloud_sql_connection_name   = module.database.connection_name
}