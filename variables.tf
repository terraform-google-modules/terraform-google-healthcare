/**
 * Copyright 2019 Google LLC
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

variable "name" {
  type        = string
  description = "The resource name for the Dataset."
}

variable "project" {
  type        = string
  description = "The ID of the project in which the resource belongs."
}

variable "location" {
  type        = string
  description = "The location for the Dataset."
}

variable "time_zone" {
  type        = string
  description = "The default timezone used by this dataset."
  default     = null
}

variable "iam_members" {
  type = list(object({
    role   = string
    member = string
  }))
  description = "Updates the IAM policy to grant a role to a new member. Other members for the role for the dataset are preserved."
  default     = []
}

# TODO(https://github.com/hashicorp/terraform/issues/19898): Convert these
# to list of objects once optional variables are supported.

# All stores are list of objects supporting the following fields:
#  name: string (required)
#  dataset: string (required)
#  labels: map(string) (optional)
#  iam_members: list of objects (optional)
#    role: string (required)
#    member: string (required)

# Extra fields for dicom_stores:
#  notification_config: object (optional)
#    pubsub_topic: string (required)
variable "dicom_stores" {
  type        = any
  description = "Datastore that conforms to the DICOM (https://www.dicomstandard.org/about/) standard for Healthcare information exchange."
  default     = []
}

# Extra fields for fhir_stores:
#  version: string (required)
#  enable_update_create: bool (optional)
#  disable_referential_integrity: bool (optional)
#  disable_resource_versioning: bool (optional)
#  enable_history_import: bool (optional)
#  notification_config: object (optional)
#    pubsub_topic: string (required)
#  stream_configs: list(object) (optional)
#    See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/healthcare_fhir_store#stream_configs for attributes
variable "fhir_stores" {
  type        = any
  description = "Datastore that conforms to the FHIR standard for Healthcare information exchange."
  default     = []
}

# Extra fields for dicom_stores:
#  notification_configs: list(object) (optional)
#    pubsub_topic: string (required)
#  parser_config: object (optional)
#    See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/healthcare_hl7_v2_store#parser_config for attributes
variable "hl7_v2_stores" {
  type        = any
  description = "Datastore that conforms to the HL7 V2 (https://www.hl7.org/hl7V2/STU3/) standard for Healthcare information exchange."
  default     = []
}

# Extra fields for consent_stores:
#  enable_consent_create_on_update: bool (optional)
#  default_consent_ttl: string (optional)
variable "consent_stores" {
  type        = any
  description = "Datastore that contain all information related to the configuration and operation of the Consent Management API (https://cloud.google.com/healthcare/docs/how-tos/consent-managing)."
  default     = []
}
