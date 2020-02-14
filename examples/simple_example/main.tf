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

provider "google" {
  version = "~> 2.0"
}

module "healthcare" {
  source = "../../"

  name     = var.name
  project  = var.project
  location = "us-central1"
  iam_members = [
    { role = "roles/healthcare.datasetAdmin", member = "group:${var.group_email}" },
    { role = "roles/healthcare.datasetViewer", member = "user:${var.user_email}" },
  ]
  dicom_stores = [
    {
      name = "example-dicom-a"
      notification_config = {
        pubsub_topic = "projects/${var.project}/topics/${var.pubsub_topic}"
      }
    },
    {
      name = "example-dicom-b"
      iam_members = [
        { role = "roles/healthcare.dicomEditor", member = "serviceAccount:${var.sa_email}" },
      ]
    }
  ]
  fhir_stores = [
    {
      name    = "example-fhir"
      version = "R4"
      notification_config = {
        pubsub_topic = "projects/${var.project}/topics/${var.pubsub_topic}"
      }
      iam_members = [
        { role = "roles/healthcare.fhirResourceEditor", member = "serviceAccount:${var.sa_email}" },
      ]
    }
  ]
  hl7_v2_stores = [
    {
      name = "example-hl7v2"
      notification_config = {
        pubsub_topic = "projects/${var.project}/topics/${var.pubsub_topic}"
      }
      iam_members = [
        { role = "roles/healthcare.hl7V2Editor", member = "serviceAccount:${var.sa_email}" },
      ]
    }
  ]
}
