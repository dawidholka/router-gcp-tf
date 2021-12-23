locals {
  envs        = [
    {
      name  = "APP_ENV"
      value = "production"
    }, {
      name  = "APP_DEBUG"
      value = false
    }, {
      name  = "LOG_CHANNEL"
      value = "stderr"
    }, {
      name  = "DB_SOCKET"
      value = "/cloudsql/${var.cloud_sql_connection_name}"
    }, {
      name  = "FORCE_HTTPS"
      value = true
    }
  ]
  secret_envs = [
    {
      key    = "DB_DATABASE"
      secret = {
        name    = var.database_database_secret_id
        version = 1
      }
    },
    {
      key    = "DB_USERNAME"
      secret = {
        name    = var.database_username_secret_id
        version = 1
      }
    },
    {
      key    = "DB_PASSWORD"
      secret = {
        name    = var.database_password_secret_id
        version = 1
      }
    }
  ]
}

resource "google_cloud_run_service" "cloud_run" {
  name     = var.name
  location = var.region

  template {
    spec {
      containers {
        image = var.container_image

        env {
          name = "APP_KEY"
          value_from {
            secret_key_ref {
              name = var.app_key_secret_id
              key  = "1"
            }
          }
        }

        dynamic env {
          for_each = local.envs
          content {
            name  = env.value.name
            value = env.value.value
          }
        }

        dynamic env {
          for_each = [for e in local.secret_envs : e if e.secret.name != null]

          content {
            name = env.value.key
            value_from {
              secret_key_ref {
                name = env.value.secret.name
                key  = env.value.secret.version
              }
            }
          }
        }

        resources {
          limits = {
            cpu    = "2000m"
            memory = "1024Mi"
          }
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "100"
        "run.googleapis.com/cloudsql-instances" = var.cloud_sql_connection_name
        "run.googleapis.com/client-name"        = "router"
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.cloud_run.location
  project  = google_cloud_run_service.cloud_run.project
  service  = google_cloud_run_service.cloud_run.name

  policy_data = data.google_iam_policy.noauth.policy_data
}