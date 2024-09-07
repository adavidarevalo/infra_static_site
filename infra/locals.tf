locals {
  route53_zoneId   = data.aws_route53_zone.myDomain.zone_id
  route53_zoneName = data.aws_route53_zone.myDomain.name
  domain = var.domain
}