# Simple Example

This example illustrates how to use the `healthcare` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| group\_email | Email for group to receive roles (ex. group@example.com) | string | n/a | yes |
| name | The name of the dataset. | string | n/a | yes |
| project | The ID of the project in which to provision resources. | string | n/a | yes |
| sa\_email | Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com) | string | n/a | yes |
| user\_email | Email for user to receive roles (Ex. user@example.com) | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
