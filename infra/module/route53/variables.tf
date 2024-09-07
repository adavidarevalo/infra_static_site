variable "route53_zone_id" {
  type = string
}

variable "domain" {
  description = "Domain Name"
  type        = string
}

variable "cloudfront_domain_name" {
  type = string
}

variable "cloudfront_hosted_zone_id" {
  type = string
}

variable "redirect_website_domain" {
  type = string
}

variable "redirect_hosted_zone_id" {
  type = string
}