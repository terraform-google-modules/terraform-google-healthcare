locals {
  all_dicom_iam_members = flatten([
    for s in var.dicom_stores : [
      for m in s.iam_members : {
        store_name = s.name
        role       = m.role
        member     = m.member
      }
    ]
  ])
  all_fhir_iam_members = flatten([
    for s in var.fhir_stores : [
      for m in s.iam_members : {
        store_name = s.name
        role       = m.role
        member     = m.member
      }
    ]
  ])
  all_hl7_v2_iam_members = flatten([
    for s in var.hl7_v2_stores : [
      for m in s.iam_members : {
        store_name = s.name
        role       = m.role
        member     = m.member
      }
    ]
  ])
}

resource "google_healthcare_dataset_iam_member" "dataset_iam_members" {
  provider = google-beta
  for_each = {
    for m in var.iam_members :
    "${m.role} ${m.member}" => m
  }
  dataset_id = google_healthcare_dataset.dataset.id
  role       = each.value.role
  member     = each.value.member
}

resource "google_healthcare_dicom_store_iam_member" "dicom_store_iam_members" {
  provider = google-beta
  for_each = {
    for m in local.all_dicom_iam_members :
    "${m.store_name} ${m.role} ${m.member}" => m
  }
  dicom_store_id = google_healthcare_dicom_store.dicom_stores[each.value.store_name].id
  role           = each.value.role
  member         = each.value.member
}

resource "google_healthcare_fhir_store_iam_member" "fhir_store_iam_members" {
  provider = google-beta
  for_each = {
    for m in local.all_fhir_iam_members :
    "${m.store_name} ${m.role} ${m.member}" => m
  }
  fhir_store_id = google_healthcare_fhir_store.fhir_stores[each.value.store_name].id
  role          = each.value.role
  member        = each.value.member
}

resource "google_healthcare_hl7_v2_store_iam_member" "hl7_v2_store_iam_members" {
  provider = google-beta
  for_each = {
    for m in local.all_hl7_v2_iam_members :
    "${m.store_name} ${m.role} ${m.member}" => m
  }
  hl7_v2_store_id = google_healthcare_hl7_v2_store.hl7_v2_stores[each.value.store_name].id
  role            = each.value.role
  member          = each.value.member
}
