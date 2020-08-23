resource "aws_cloudtrail" "website_object_log" {
  name                          = "ct-s3-${aws_s3_bucket.website.bucket}"
  s3_bucket_name                = var.global_log_bucket
  include_global_service_events = false

  tags = {
    Environment = local.global_tag_environment
    Service     = local.global_tag_service
  }

  event_selector {
    read_write_type           = "WriteOnly"
    include_management_events = false

    data_resource {
      type = "AWS::S3::Object"
      values = ["${aws_s3_bucket.website.arn}/"]
    }
  }
}

output "cloudtrail_name" {
  value = aws_cloudtrail.website_object_log.name
}
