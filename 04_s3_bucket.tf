resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket" "art_bucket" {
  bucket = var.artifact_bucket
}

resource "aws_s3_bucket" "backend_art_bucket" {
  bucket = var.backend_artifact_bucket
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.my_bucket_policy.json
}

data "aws_iam_policy_document" "my_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.my_bucket.id}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "my_bucket_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "frontend-endpoint" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}