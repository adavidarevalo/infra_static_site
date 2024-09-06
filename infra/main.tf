terraform {
    required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
      aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58"
    }
  }
}


module "S3Website" {
  source = "./module/s3"

  bucket_name = var.bucket_name

  website_relative_path = var.website_relative_path

  tags = var.tags
}