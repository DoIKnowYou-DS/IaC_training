output "aws_s3_bucket" {
  value = aws_s3_bucket.bucket.bucket
}

output "iam_role" {
  value = aws_iam_role.snowflake_s3_access.arn
}