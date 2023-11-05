resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  region        = "us-west-2"
  acl           = "public-read"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-data"
    Environment = local.resource_prefix.value
    yor_trace   = "2af60869-f9d8-4579-8405-e8b8058ce0fd"
  }
}

resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  region = "us-west-2"
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"
  tags = {
    Name        = "${local.resource_prefix.value}-customer-master"
    Environment = local.resource_prefix.value
    yor_trace   = "7adee2c7-9153-4ecb-bd85-9aa498a09050"
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  region        = "us-west-2"
  acl           = "private"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-financials"
    Environment = local.resource_prefix.value
    yor_trace   = "aa632591-4e35-4c9b-8cfe-41ff1aca08e1"
  }

}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket = "${local.resource_prefix.value}-operations"
  region = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-operations"
    Environment = local.resource_prefix.value
    yor_trace   = "4efda974-c5a8-4e6b-b350-820f638a4d65"
  }

}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  region = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true
  tags = {
    yor_trace = "ccdb19f3-c9c2-4474-a561-34975229734a"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  region = "us-west-2"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
    yor_trace   = "9857e9bc-4d92-4466-8046-a094978963e1"
  }
}
