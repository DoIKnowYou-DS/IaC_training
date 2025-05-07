module "s3" {
  source            = "../module/aws/s3"
  pj_name          = local.common.pj_name
  id               = module.snowflake.snowflake_external_id
}

module "snowflake" {
  source            = "../module/snowflake"
  db_name           = local.snowflake.db_name
  schema_name       = local.snowflake.schema_name
  aws_s3_bucket     = module.s3.aws_s3_bucket
  iam_role          = module.s3.iam_role
  providers = {
    snowflake.sysadmin = snowflake.sysadmin
  }
}