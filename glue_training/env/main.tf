module "s3" {
  source            = "../module/aws/s3"
  pj_name           = local.common.pj_name
}