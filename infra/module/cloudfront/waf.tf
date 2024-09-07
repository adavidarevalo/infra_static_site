resource "aws_wafv2_web_acl" "cloudfront_acl" {
  name        = "cloudfront-web-acl"
  description = "Allow access only through a specific domain"
  scope       = "CLOUDFRONT"
  default_action {
    block {}
  }

  rule {
    name     = "AllowFromSpecificDomain"
    priority = 1
    action {
      allow {}
    }

    statement {
      byte_match_statement {
        search_string = var.domain
        field_to_match {
          single_header {
            name = "host"
          }
        }
        positional_constraint = "EXACTLY"
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AllowFromSpecificDomain"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "cloudfrontWebACL"
    sampled_requests_enabled   = true
  }
}
