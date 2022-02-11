terraform {
  required_version = ">= 0.14"

  required_providers {
    # Cloud Run support was added on 3.3.0
    google = ">= 3.3"
  }
}
provider "google" {
  # Replace PROJECT_ID with your project
  project = "q-gcp-6508-rsg-docai-22-01"
}
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = false
}
resource "google_cloud_run_service" "run_service" {
  name = "app22"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/q-gcp-6508-rsg-docai-22-01/cloud-run-hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Waits for the Cloud Run API to be enabled
  depends_on = [google_project_service.run_api]
}
resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_service.run_service.name
  location = google_cloud_run_service.run_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
output "service_url" {
  value = google_cloud_run_service.run_service.status[0].url
}