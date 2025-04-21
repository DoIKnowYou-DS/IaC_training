resource "aws_iam_role" "producer_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy" "producer_role_policy" {
  name = "${var.pj_name}-producer-role"
  role = aws_iam_role.producer_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
        "kinesis:PutRecord",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:kinesis:${var.region}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exc_producer" {
  role = aws_iam_role.producer_role.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

resource "aws_iam_role" "processor_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy" "processor_role_policy" {
  name = "${var.pj_name}-processor-role"
  role = aws_iam_role.processor_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
        "kinesis:GetRecords",
        "kinesis:GetShardIterator",
        "kinesis:DescribeStream",
        "kinesis:DescribeStreamSummary",
        "kinesis:ListShards",
        "kinesis:ListStreams"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:kinesis:${var.region}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
      },
    {
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.s3_bucket}/processed/*"
    }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exc_processor" {
  role = aws_iam_role.processor_role.name
  policy_arn = data.aws_iam_policy.lambda_basic_execution.arn
}

data "aws_iam_policy" "lambda_basic_execution" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}