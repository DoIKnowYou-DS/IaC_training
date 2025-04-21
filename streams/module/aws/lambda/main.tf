data "archive_file" "producer_lambda_file" {
  type        = "zip"
  source_file = "script/producer.py"
  output_path = "producer.zip"
}

resource "aws_lambda_function" "lambda_producer" {
  function_name = "${var.pj_name}-producer-lambda-function"
  filename = data.archive_file.producer_lambda_file.output_path
  role = aws_iam_role.producer_role.arn
  handler = "lambda_handler"
  source_code_hash = data.archive_file.producer_lambda_file.output_base64sha256

  runtime = var.runtime

  environment {
    variables = {
      "STREAM_NAME" = var.stream_name
    }
  }
}

