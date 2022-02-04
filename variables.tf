locals {
    data_lake_bucket = "dtc_data_lake"
}

variable "project" {
    description = ""
}

variable "region" {
    description = 
    default = "europe-west6"
    type = string
}

variable "storage_class" {
    description = ""
    default = "STANDARD"
}
variable "BQ_DATASET" {
    description = ""
    type = string
    default = "trips_data_all"
}