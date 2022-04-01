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

output "dicom_stores" {
  value       = google_healthcare_dicom_store.dicom_stores
  description = "Attributes for all DICOM stores."
}

output "fhir_stores" {
  value       = google_healthcare_fhir_store.fhir_stores
  description = "Attributes for all FHIR stores."
}

output "hl7_v2_stores" {
  value       = google_healthcare_hl7_v2_store.hl7_v2_stores
  description = "Attributes for all HL7 V2 stores."
}

output "consent_stores" {
  value       = google_healthcare_consent_store.consent_stores
  description = "Attributes for all Consent stores."
}
