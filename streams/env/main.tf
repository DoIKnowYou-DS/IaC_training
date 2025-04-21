module "s3" {
  source            = "../module/aws/s3"
  pj_name           = local.common.pj_name
}

module "kinesis" {
  source            = "../module/aws/kinesis"
  pj_name           = local.common.pj_name
}

module "lambda" {
  source            = "../module/aws/lambda"
  pj_name           = local.common.pj_name
  runtime           = local.lambda.runtime
  region            = local.common.region
  stream_arn        = module.kinesis.stream_arn
  stream_name       = module.kinesis.stream_name
  s3_bucket         = module.s3.aws_s3_bucket
}