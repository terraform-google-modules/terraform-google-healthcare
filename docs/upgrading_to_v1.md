# Upgrading to v1.0

The v1.0 release of *healthcare* is a backwards incompatible release.

## API

All resources now use the GA v1 API rather than v1beta.

## HL7 Notification Configs

The GA API requires notification configs to be a list.

```diff
module "healthcare" {
    source  = "terraform-google-modules/healthcare/google"
-   version = "~> 0.1"
+   version = "~> 1.0"

    name     = "example-dataset"
    project  = "example-project"
    location = "us-central1"

    hl7_v2_stores = [{
      name = "example-hl7v2"
-      notification_config = {
+      notification_configs = [{
        pubsub_topic = "projects/${var.project}/topics/${var.pubsub_topic}"
-      }
+      }]
    }]
}
```
