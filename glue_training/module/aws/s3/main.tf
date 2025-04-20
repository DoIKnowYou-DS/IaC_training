resource "aws_s3_bucket" "bucket" {
  bucket = "${var.pj_name}-bucket"
}

# /raw/ フォルダっぽく見せる
resource "aws_s3_object" "raw_folder" {
  bucket = aws_s3_bucket.bucket.id
  key    = "raw/"
}

# /processed/ フォルダっぽく見せる
resource "aws_s3_object" "processed_folder" {
  bucket = aws_s3_bucket.bucket.id
  key    = "processed/"
}

# glue job のスクリプト置き場
resource "aws_s3_object" "scripts_folder" {
  bucket = aws_s3_bucket.bucket.id
  key    = "script/"
}

resource "aws_s3_object" "csv" {
  bucket = aws_s3_bucket.bucket.id
  key = "raw/sample_users.csv"
  source = "${path.module}/sample_users.csv"
}

resource "aws_s3_object" "job" {
  bucket = aws_s3_bucket.bucket.id
  key = "script/glue_job.py"
  source = "${path.module}/glue_job.py"
}