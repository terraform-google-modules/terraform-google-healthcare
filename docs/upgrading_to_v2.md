# Upgrading to v2.5.0

## Pipeline Jobs

The GA API enables creation of HDE Pipeline Jobs.

```
module "healthcare" {
    source  = "terraform-google-modules/healthcare/google"
    version = "~> 2.5.0"

    name     = "example-dataset"
    project  = "example-project"
    location = "us-central1"

    pipeline_jobs = [
    {
      name                   = "example-backfill-pipeline"
      dataset                = "example-dataset"
      backfill_pipeline_job {
        mapping_pipeline_job = "example-mapping-pipeline"
      }
    }
  ]
}
```

## Minimum Google Provider versions

Minimum Google Provider versions have been updated to 6.5.0
