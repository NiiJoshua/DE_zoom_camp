terraform {
    required_version = ">= 1.0"
    backend "local" {}
    required_providers {
        google = {
            source = "hashicopr/google"
        }
    }
}

provider "google" {
    project = var.project
    region = var.region
    // credentials = file(var.credentials)
}
# Data Lake Bucket
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "data-lake-bucket" {
    name = "${local.data_lake_bucket}_${var.project}"
    location = var.region

    # optional parameters
    storage_class = var.storage_class
    uniform_bucket_level_access = true

    versioning {
        enable = true
    }
    lifecycle_rule {
        action {
            type = "Delete"
        }
        condition {
            age = 30 // days
        }
    }

    force_destroy = true
}

# DWH
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset

resource "google_bigquery_dataset" "dataset" {
    dataset_id = var.bigquery_dataset
    project    = var.project
    location   = var.region
}

