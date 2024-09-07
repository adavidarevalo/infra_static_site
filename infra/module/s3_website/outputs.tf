output "s3_bucket_id" {
  value = module.public_s3.s3_bucket_id
}

output "bucket_regional_domain_name" {
  value = module.public_s3.s3_bucket_bucket_regional_domain_name
}

output "redirect_website_domain" {
  value = module.redirect.s3_bucket_website_domain
}

output "redirect_hosted_zone_id" {
  value = module.redirect.s3_bucket_hosted_zone_id
}