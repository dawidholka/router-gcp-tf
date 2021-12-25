resource "random_string" "random" {
  length  = 6
  special = false
  number  = false
  upper   = false
}

data "http" "current_ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "google_sql_database_instance" "instance" {
  name                = "${var.database_instance_name}-${random_string.random.result}"
  region              = var.region
  database_version    = var.database_version
  deletion_protection = false

  settings {
    tier = var.database_tier

    ip_configuration {
      authorized_networks {
        expiration_time = timeadd(timestamp(), "30m")
        name            = "terraform"
        value           = "${chomp(data.http.current_ip.body)}/32"
      }
    }
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
