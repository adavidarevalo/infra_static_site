module "public_s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = var.bucket_name

  force_destroy            = true
  object_lock_enabled      = false
  control_object_ownership = true

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false

 versioning = {
    status     = true
    mfa_delete = false
  }
  website = {
    index_document = "index.html"
  }

  tags = var.tags
}

resource "aws_s3_bucket_policy" "s3_public_policy" {
  bucket = module.public_s3.s3_bucket_id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "null_resource" "remove_and_upload_to_s3" {
provisioner "local-exec" {
  command = "aws s3 sync ${var.website_relative_path} s3://${module.public_s3.s3_bucket_id}"
}
}