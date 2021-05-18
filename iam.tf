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

locals {
  all_dicom_iam_members = flatten([
    for s in var.dicom_stores : [
      for m in lookup(s, "iam_members", []) : {
        store_name = s.name
        role       = m.role
        member     = m.member
      }
    ]
  ])
  all_fhir_iam_members = flatten([
    for s in var.fhir_stores : [
      for m in lookup(s, "iam_members", []) : {
        store_name = s.name
        role       = m.role
        member     = m.member
      }
    ]
  ])
  all_hl7_v2_iam_members = flatten([
    for s in var.hl7_v2_stores : [
      for m in lookup(s, "iam_members", []) : {
        store_name = s.name
        role       = m.role
        member     = m.member
      }
    ]
  ])
  all_consent_iam_members = flatten([
    for s in var.consent_stores : [
      for m in lookup(s, "iam_members", []) : {
        store_name = s.name
        role       = m.role
        member     = m.member
      }
    ]
  ])
}

resource "google_healthcare_dataset_iam_member" "dataset_iam_members" {
  for_each = {
    for m in var.iam_members :
    "${m.role} ${m.member}" => m
  }
  dataset_id = google_healthcare_dataset.dataset.id
  role       = each.value.role
  member     = each.value.member
}

resource "google_healthcare_dicom_store_iam_member" "dicom_store_iam_members" {
  for_each = {
    for m in local.all_dicom_iam_members :
    "${m.store_name} ${m.role} ${m.member}" => m
  }
  dicom_store_id = google_healthcare_dicom_store.dicom_stores[each.value.store_name].id
  role           = each.value.role
  member         = each.value.member
}

resource "google_healthcare_fhir_store_iam_member" "fhir_store_iam_members" {
  for_each = {
    for m in local.all_fhir_iam_members :
    "${m.store_name} ${m.role} ${m.member}" => m
  }
  fhir_store_id = google_healthcare_fhir_store.fhir_stores[each.value.store_name].id
  role          = each.value.role
  member        = each.value.member
}

resource "google_healthcare_hl7_v2_store_iam_member" "hl7_v2_store_iam_members" {
  for_each = {
    for m in local.all_hl7_v2_iam_members :
    "${m.store_name} ${m.role} ${m.member}" => m
  }
  hl7_v2_store_id = google_healthcare_hl7_v2_store.hl7_v2_stores[each.value.store_name].id
  role            = each.value.role
  member          = each.value.member
}

resource "google_healthcare_consent_store_iam_member" "consent_store_iam_members" {
  for_each = {
    for m in local.all_consent_iam_members :
    "${m.store_name} ${m.role} ${m.member}" => m
  }
  consent_store_id = google_healthcare_consent_store.consent_stores[each.value.store_name].id
  dataset          = google_healthcare_consent_store.consent_stores[each.value.store_name].dataset
  role             = each.value.role
  member           = each.value.member
}
