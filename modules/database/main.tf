resource "google_sql_database_instance" "instance" {
  name                = var.database_instance_name
  region              = var.region
  database_version    = var.database_version
  deletion_protection = false

  settings {
    tier = var.database_tier
  }
}

resource "google_sql_database" "database" {
  name     = var.database_database_name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "users" {
  name     = "router"
  instance = google_sql_database_instance.instance.name
  host     = "%"
  password = var.database_password
}
