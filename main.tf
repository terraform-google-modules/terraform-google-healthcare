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
  provider = google-beta

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

  dynamic "stream_configs" {
    for_each = lookup(each.value, "stream_configs", [])

    content {
      bigquery_destination {
        table_uri = stream_configs.value.bigquery_destination.table_uri
      }
    }
  }
}

resource "google_healthcare_fhir_store" "fhir_stores" {
  provider = google-beta

  for_each = {
    for s in var.fhir_stores :
    s.name => s
  }

  name    = each.value.name
  dataset = google_healthcare_dataset.dataset.id
  version = each.value.version
  labels  = lookup(each.value, "labels", null)

  enable_update_create                = lookup(each.value, "enable_update_create", null)
  disable_referential_integrity       = lookup(each.value, "disable_referential_integrity", null)
  disable_resource_versioning         = lookup(each.value, "disable_resource_versioning", null)
  enable_history_import               = lookup(each.value, "enable_history_import", null)
  complex_data_type_reference_parsing = lookup(each.value, "complex_data_type_reference_parsing", null)

  dynamic "notification_config" {
    for_each = lookup(each.value, "notification_config", null) != null ? [each.value.notification_config] : []
    content {
      pubsub_topic = notification_config.value.pubsub_topic
    }
  }

  dynamic "notification_configs" {
    for_each = lookup(each.value, "notification_configs", [])
    content {
      pubsub_topic                     = lookup(notification_configs.value, "pubsub_topic", null)
      send_full_resource               = lookup(notification_configs.value, "send_full_resource", null)
      send_previous_resource_on_delete = lookup(notification_configs.value, "send_previous_resource_on_delete", null)
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

          dynamic "last_updated_partition_config" {
            for_each = lookup(stream_configs.value.bigquery_destination.schema_config, "last_updated_partition_config", null) != null ? [stream_configs.value.bigquery_destination.schema_config.last_updated_partition_config] : []
            content {
              type          = last_updated_partition_config.value.type
              expiration_ms = lookup(last_updated_partition_config.value, "expiration_ms", null)
            }
          }
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

  dynamic "parser_config" {
    for_each = lookup(each.value, "parser_config", null) != null ? [each.value.parser_config] : []
    content {
      allow_null_header  = lookup(parser_config.value, "allow_null_header", null)
      segment_terminator = lookup(parser_config.value, "segment_terminator", null)
      schema             = lookup(parser_config.value, "schema", null)
      version            = lookup(parser_config.value, "version", null)
    }
  }
}

resource "google_healthcare_consent_store" "consent_stores" {
  for_each = {
    for s in var.consent_stores :
    s.name => s
  }

  name                            = each.value.name
  dataset                         = google_healthcare_dataset.dataset.id
  labels                          = lookup(each.value, "labels", null)
  enable_consent_create_on_update = lookup(each.value, "enable_consent_create_on_update", null)
  default_consent_ttl             = lookup(each.value, "default_consent_ttl", null)
}

resource "google_healthcare_workspace" "workspaces" {
  for_each = {
    for s in var.workspaces :
    s.name => s
  }

  name    = each.value.name
  dataset = google_healthcare_dataset.dataset.id
  labels  = lookup(each.value, "labels", null)
  settings {
    data_project_ids = lookup(each.value.settings, "data_project_ids", [])
  }
}

resource "google_healthcare_pipeline_job" "pipeline_jobs" {
  for_each = {
    for s in var.pipeline_jobs :
    s.name => s
  }

  name    = each.value.name
  dataset = google_healthcare_dataset.dataset.id
  labels  = lookup(each.value, "labels", null) 
  disable_lineage = lookup(each.value, "disable_lineage", null)
  dynamic "reconciliation_pipeline_job" {
    for_each = lookup(each.value, "reconciliation_pipeline_job", [])
    merge_config {
      description = lookup(reconciliation_pipeline_job.value.merge_config, "description", null)
      whistle_config_source {
        uri = lookup(reconciliation_pipeline_job.value.merge_config.whistle_config_source, "uri", null)
        import_uri_prefix = lookup(reconciliation_pipeline_job.value.merge_config.whistle_config_source, "import_uri_prefix", null)
      }
    }
    matching_uri_prefix = lookup(reconciliation_pipeline_job.value, "matching_uri_prefix", null)
    fhir_store_destination = lookup(reconciliation_pipeline_job.value, "fhir_store_destination", null)
  }

  dynamic "reconciliation_pipeline_job" {
    for_each = lookup(each.value, "reconciliation_pipeline_job", [])
    merge_config {
      description = lookup(reconciliation_pipeline_job.value.merge_config, "description", null)
      whistle_config_source {
        uri = lookup(reconciliation_pipeline_job.value.merge_config.whistle_config_source, "uri", null)
        import_uri_prefix = lookup(reconciliation_pipeline_job.value.merge_config.whistle_config_source, "import_uri_prefix", null)
      }
    }
    matching_uri_prefix = lookup(reconciliation_pipeline_job.value, "matching_uri_prefix", null)
    reconciliation_destination = lookup(reconciliation_pipeline_job.value, "reconciliation_destination", null)
  }

  dynamic "backfill_pipeline_job" {
    for_each = lookup(each.value, "backfill_pipeline_job", [])
    mapping_pipeline_job = lookup(backfill_pipeline_job.value, "mapping_pipeline_job", null)
  }

  dynamic "mapping_pipeline_job" {
    for_each = lookup(each.value, "mapping_pipeline_job", [])
    mapping_config {
      whistle_config_source {
        uri = lookup(mapping_pipeline_job.value.mapping_config.whistle_config_source, "uri", null)
        import_uri_prefix = lookup(mapping_pipeline_job.value.mapping_config.whistle_config_source, "import_uri_prefix", null)
      }
      description = lookup(mapping_pipeline_job.value.mapping_config, "description", null)
    }
    fhir_streaming_source {
      fhir_store = lookup(mapping_pipeline_job.value, "fhir_store", null)
    }
    fhir_store_destination = lookup(mapping_pipeline_job.value, "fhir_store_destination", null)
  }
}
