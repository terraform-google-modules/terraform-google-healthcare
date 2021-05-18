# terraform-google-healthcare

This module handles opinionated Google Cloud Platform Healthcare datasets and stores.

## Usage

Basic usage of this module is as follows:

```hcl
module "healthcare" {
  source  = "terraform-google-modules/healthcare/google"
  version = "~> 1.2"

  project  = "<PROJECT_ID>"
  name     = "example-dataset"
  location = "us-central1"
  dicom_stores = [{
    name = "example-dicom-store"
    iam_members = [
      { role = "roles/healthcare.dicomEditor", member = "user:example@domain.com" }
    ]
  }]
  fhir_stores = [{
    name         = "example-fhir-store"
    version      = "R4"
    notification_config = {
      pubsub_topic = "projects/<PROJECT_ID>/topics/example_topic"
    }
  }]
}
```

Functional examples are included in the
[examples](./examples/) directory.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.67.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Healthcare Dataset Admin: `roles/healthcare.datasetAdmin`
- Healthcare DICOM Admin: `roles/healthcare.dicomStoreAdmin`
- Healthcare FHIR Admin: `roles/healthcare.fhirStoreAdmin`
- Healthcare HL7 V2 Admin: `roles/healthcare.hl7V2StoreAdmin`
- Healthcare Consent Admin: `roles/healthcare.ConsentStoreAdmin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

To allow messages to be published from the Cloud Healthcare API to Pub/Sub,
you must add the `roles/pubsub.publisher` role to your project's [Cloud Healthcare
Service Agent service account](https://cloud.google.com/healthcare/docs/how-tos/controlling-access-other-products#the_cloud_healthcare_service_agent).

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Healthcare API: `healthcare.googleapis.com`

To allow messages to be published from the Cloud Healthcare API to Pub/Sub,
the following API also needs to be enabled:
- Google Pub/Sub API: `pubsub.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| consent\_stores | Datastore that contain all information related to the configuration and operation of the Consent Management API (https://cloud.google.com/healthcare/docs/how-tos/consent-managing). | `any` | `[]` | no |
| dicom\_stores | Datastore that conforms to the DICOM (https://www.dicomstandard.org/about/) standard for Healthcare information exchange. | `any` | `[]` | no |
| fhir\_stores | Datastore that conforms to the FHIR standard for Healthcare information exchange. | `any` | `[]` | no |
| hl7\_v2\_stores | Datastore that conforms to the HL7 V2 (https://www.hl7.org/hl7V2/STU3/) standard for Healthcare information exchange. | `any` | `[]` | no |
| iam\_members | Updates the IAM policy to grant a role to a new member. Other members for the role for the dataset are preserved. | <pre>list(object({<br>    role   = string<br>    member = string<br>  }))</pre> | `[]` | no |
| location | The location for the Dataset. | `string` | n/a | yes |
| name | The resource name for the Dataset. | `string` | n/a | yes |
| project | The ID of the project in which the resource belongs. | `string` | n/a | yes |
| time\_zone | The default timezone used by this dataset. | `string` | `null` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
