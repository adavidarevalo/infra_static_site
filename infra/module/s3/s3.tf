data "template_file" "s3_public_policy" {
  template = file("./policy.json")

  vars = {
    bucket_name = var.bucket_name
  }
}

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

  policy = data.template_file.s3_public_policy.rendered

  versioning = true

  website = {
    index_document = "index.html"
  }

  tags = var.tags
}


# Upload files to S3 Bucket 
resource "aws_s3_object" "provision_source_files" {
    bucket  = module.public_s3.s3_bucket_id
    
    for_each = fileset("./../../../website", "**/*.*") 
    
    key    = each.value
    source = "./../../../website/${each.value}"
    content_type = each.value
}