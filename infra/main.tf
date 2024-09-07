terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58"
    }
  }
}


module "s3Logs" {
  source = "./module/s3_logs"

    bucket_name = var.domain

      tags = var.tags  
}


module "S3Website" {
  source = "./module/s3_website"

  bucket_name = var.domain

  website_relative_path = var.website_relative_path

  logs_bucket_id = module.s3Logs.logs_bucket_id

  tags = var.tags
}

module "acm" {
  source = "./module/acm"

  domain = var.domain

  route53_zone_id = local.route53_zoneId
}

module "cloudFront" {
  source = "./module/cloudfront"

  domain = var.domain

  s3_bucket_id = module.S3Website.s3_bucket_id

  bucket_regional_domain_name = module.S3Website.bucket_regional_domain_name

  certificate_arn = module.acm.certificate_arn

  tags = var.tags
}

module "route53" {
  source = "./module/route53"

  route53_zone_id = local.route53_zoneId
  domain = local.domain

  cloudfront_domain_name = module.cloudFront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudFront.cloudfront_hosted_zone_id

  redirect_website_domain = module.S3Website.redirect_website_domain
  redirect_hosted_zone_id = module.S3Website.redirect_hosted_zone_id
}