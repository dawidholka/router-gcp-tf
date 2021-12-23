resource "docker_image" "migrate_database" {
  name = "dawidholka/router:${var.image_tag}"
}

resource "docker_container" "migrate_database" {
  name    = "migrate_router"
  image   = docker_image.migrate_database.latest
  env     = [
    "APP_KEY=\"${var.app_key}\"",
    "DB_HOST=${var.database_host}",
    "DB_PASSWORD=${var.database_password}",
    "DB_USERNAME=${var.database_username}",
    "DB_DATABASE=${var.database_database}",
    "LOG_CHANNEL=stderr"
  ]
  command = [
    "php",
    "artisan",
    "migrate",
    "--force"
  ]
}