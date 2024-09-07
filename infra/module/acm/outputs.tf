output "certificate_arn" {
  value = aws_acm_certificate_validation.app_certificate_validation.certificate_arn
}