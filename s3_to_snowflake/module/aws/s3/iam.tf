# 1. IAMロール（SnowflakeがAssumeするためのロール）
resource "aws_iam_role" "snowflake_s3_access" {
  name = "snowflake-s3-access-role"

  assume_role_policy = jsonencode({
  Version = "2012-10-17",
  Statement = [
    {
      Effect = "Allow",
      Principal = {
        AWS = "arn:aws:iam::414351767826:root"
      },
      Action = "sts:AssumeRole",
      Condition = {
        StringEquals = {
          "sts:ExternalId" = var.id
        }
      }
    }
  ]
})

}

# 2. IAMポリシー（S3読み取り用）
resource "aws_iam_policy" "snowflake_s3_policy" {
  name = "snowflake-s3-read-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*"
        ]
      }
    ]
  })
}

# 3. ロールにポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "snowflake_attach" {
  role       = aws_iam_role.snowflake_s3_access.name
  policy_arn = aws_iam_policy.snowflake_s3_policy.arn
}
