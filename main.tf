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

resource "google_healthcare_dataset" "dataset" {
  name      = var.name
  project   = var.project
  location  = var.location
  time_zone = var.time_zone
}

resource "google_healthcare_dicom_store" "dicom_stores" {
  for_each = {
    for s in var.dicom_stores :
    s.name => s
  }

  name    = each.value.name
  dataset = google_healthcare_dataset.dataset.id
  labels  = lookup(each.value, "labels", null)

  dynamic "notification_config" {
    for_each = lookup(each.value, "notification_config", null) != null ? [each.value.notification_config] : []
    content {
      pubsub_topic = notification_config.value.pubsub_topic
    }
  }

}

resource "google_healthcare_fhir_store" "fhir_stores" {
  for_each = {
    for s in var.fhir_stores :
    s.name => s
  }

  name    = each.value.name
  dataset = google_healthcare_dataset.dataset.id
  version = each.value.version
  labels  = lookup(each.value, "labels", null)

  dynamic "notification_config" {
    for_each = lookup(each.value, "notification_config", null) != null ? [each.value.notification_config] : []
    content {
      pubsub_topic = notification_config.value.pubsub_topic
    }
  }

  dynamic "stream_configs" {
    for_each = lookup(each.value, "stream_configs", [])

    content {
      resource_types = lookup(stream_configs.value, "resource_types", null)

      bigquery_destination {
        dataset_uri = stream_configs.value.bigquery_destination.dataset_uri

        schema_config {
          schema_type               = lookup(stream_configs.value.bigquery_destination.schema_config, "schema_type", null)
          recursive_structure_depth = stream_configs.value.bigquery_destination.schema_config.recursive_structure_depth
        }
      }
    }
  }
}

resource "google_healthcare_hl7_v2_store" "hl7_v2_stores" {
  provider = google-beta
  for_each = {
    for s in var.hl7_v2_stores :
    s.name => s
  }

  name    = each.value.name
  dataset = google_healthcare_dataset.dataset.id
  labels  = lookup(each.value, "labels", null)

  dynamic "notification_configs" {
    for_each = lookup(each.value, "notification_configs", [])
    content {
      pubsub_topic = notification_configs.value.pubsub_topic
    }
  }
}
