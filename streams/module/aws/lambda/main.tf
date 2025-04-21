data "archive_file" "producer_lambda_file" {
  type        = "zip"
  source_file = "${path.module}/script/producer.py"
  output_path = "producer.zip"
}

resource "aws_lambda_function" "lambda_producer" {
  function_name = "${var.pj_name}-producer-lambda-function"
  filename = data.archive_file.producer_lambda_file.output_path
  role = aws_iam_role.producer_role.arn
  handler = "producer.lambda_handler"
  source_code_hash = data.archive_file.producer_lambda_file.output_base64sha256

  runtime = var.runtime

  environment {
    variables = {
      "STREAM_NAME" = var.stream_name
    }
  }
}

resource "aws_lambda_event_source_mapping" "kinesis_mapping" {
  event_source_arn = var.stream_arn
  function_name = aws_lambda_function.lambda_processor.arn
  starting_position = "LATEST"
}

data "archive_file" "processor_lambda_file" {
  type        = "zip"
  source_file = "${path.module}/script/processor.py"
  output_path = "processor.zip"
}

resource "aws_lambda_function" "lambda_processor" {
  function_name = "${var.pj_name}-processor-lambda-function"
  filename = data.archive_file.processor_lambda_file.output_path
  role = aws_iam_role.processor_role.arn
  handler = "processor.lambda_handler"
  source_code_hash = data.archive_file.processor_lambda_file.output_base64sha256

  runtime = var.runtime

  environment {
    variables = {
      "Bucket_name" = var.s3_bucket
    }
  }
}