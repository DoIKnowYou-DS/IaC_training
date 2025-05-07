resource "aws_s3_bucket" "bucket" {
  bucket = "${var.pj_name}-bucket"
}

resource "aws_s3_object" "raw_folder" {
  bucket = aws_s3_bucket.bucket.id
  key    = "incoming/"
}

resource "aws_s3_object" "csv" {
  bucket = aws_s3_bucket.bucket.id
  key = "incoming/sample_data.csv"
  source = "${path.module}/sample_data.csv"
}