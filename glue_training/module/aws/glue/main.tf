resource "aws_glue_crawler" "crawler_raw" {
  database_name = aws_glue_catalog_database.etl_db.name
  name          = "${var.pj_name}-crawler-raw"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${var.s3_bucket}"
  }

  table_prefix = var.raw_prefix
}