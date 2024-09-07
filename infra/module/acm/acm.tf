resource "aws_acm_certificate" "app_certificate" {
  domain_name = var.domain

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain}"
  ]

  tags = {
    Name = "App Certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "app_certificate_validation" {
  for_each = {
    for d in aws_acm_certificate.app_certificate.domain_validation_options : d.domain_name => d
  }

  zone_id = var.route53_zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "app_certificate_validation" {
  certificate_arn = aws_acm_certificate.app_certificate.arn

  validation_record_fqdns = [
    for r in aws_route53_record.app_certificate_validation : r.fqdn
  ]
}
