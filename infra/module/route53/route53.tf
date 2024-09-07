resource "aws_route53_record" "app_dns" {
  zone_id = var.route53_zone_id
  name    = "${var.domain}"
  type    = "A"
  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www_app_dns" {
  zone_id = var.route53_zone_id
  name    = "www.${var.domain}"
  type    = "A"
  alias {
    name                   = var.redirect_website_domain
    zone_id                = var.redirect_hosted_zone_id
    evaluate_target_health = false
  }
}
