/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "google_service_account" "service_account" {
  account_id = "example-sa"
  project    = var.project
}

resource "google_bigquery_dataset" "example_dataset" {
  dataset_id    = "example_dataset"
  friendly_name = "Default Dataset"
  project       = var.project
}

module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic      = "example-topic"
  project_id = var.project
}

locals {
  sa_member    = "serviceAccount:${google_service_account.service_account.account_id}@${var.project}.iam.gserviceaccount.com"
  pubsub_topic = "projects/${var.project}/topics/${module.pubsub.topic}"
}

module "healthcare" {
  source = "../../"

  name     = "example-healthcare-dataset"
  project  = var.project
  location = "us-central1"
  iam_members = [{
    role   = "roles/healthcare.datasetViewer"
    member = local.sa_member
  }]
  dicom_stores = [
    {
      name = "example-dicom-a"
      notification_config = {
        pubsub_topic = local.pubsub_topic
      }
    },
    {
      name = "example-dicom-b"
      iam_members = [{
        role   = "roles/healthcare.dicomEditor"
        member = local.sa_member
      }]
    }
  ]
  fhir_stores = [
    {
      name                          = "example-fhir"
      version                       = "R4"
      enable_update_create          = true
      disable_referential_integrity = false
      disable_resource_versioning   = false
      enable_history_import         = false
      notification_config = {
        pubsub_topic = local.pubsub_topic
      }
      stream_configs = [{
        bigquery_destination = {
          dataset_uri = "bq://${var.project}.${google_bigquery_dataset.example_dataset.dataset_id}"
          schema_config = {
            recursive_structure_depth = 3
          }
        }
      }]
      iam_members = [{
        role   = "roles/healthcare.fhirResourceEditor"
        member = local.sa_member
      }]
    }
  ]
  hl7_v2_stores = [
    {
      name = "example-hl7v2"
      notification_configs = [{
        pubsub_topic = local.pubsub_topic
      }]
      parser_config = {
        schema  = <<EOF
          {
            "schematizedParsingType": "SOFT_FAIL",
            "ignoreMinOccurs": true
          }
        EOF
        version = "V2"
      }
      iam_members = [{
        role   = "roles/healthcare.hl7V2Editor"
        member = local.sa_member
      }]
    }
  ]
  consent_stores = [
    {
      name                            = "example-consent"
      enable_consent_create_on_update = false
      default_consent_ttl             = "90000s"
      iam_members = [{
        role   = "roles/healthcare.consentEditor"
        member = local.sa_member
      }]
    }
  ]
}
