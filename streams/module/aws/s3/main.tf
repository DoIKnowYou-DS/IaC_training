resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.pj_name}-bucket"
  force_destroy = true
}

