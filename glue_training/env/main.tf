module "s3" {
  source            = "../module/aws/s3"
  pj_name           = local.common.pj_name
}

module "glue" {
  source            = "../module/aws/glue"
  pj_name           = local.common.pj_name
  raw_prefix        = local.glue.raw_prefix
  s3_bucket         = module.s3.s3_bucket
}