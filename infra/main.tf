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
  source = "./module/s3_website"

  bucket_name = var.domain

  website_relative_path = var.website_relative_path

  tags = var.tags
}

module "cloudFront" {
  source = "./module/cloudfront"

  domain = var.domain

  s3_bucket_id = module.S3Website.s3_bucket_id

  bucket_regional_domain_name = module.S3Website.bucket_regional_domain_name

  tags = var.tags
}

