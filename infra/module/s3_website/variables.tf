variable "bucket_name" {
  type = string
}

variable "tags" {
  type = object({})
}

variable "website_relative_path" {
  type = string
}

variable "logs_bucket_id" {
  type = string
}