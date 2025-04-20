resource "aws_glue_crawler" "crawler_raw" {
  database_name = aws_glue_catalog_database.etl_db.name
  name          = "${var.pj_name}-crawler-raw"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${var.s3_bucket}/raw"
  }

  table_prefix = var.raw_prefix
}

resource "aws_glue_job" "glue_job" {
  name = "${var.pj_name}-glue-job"
  role_arn = aws_iam_role.glue_role.arn
  command {
    script_location = "s3://${var.s3_bucket}/script/glue_job.py"
  }

  default_arguments = {
    "--TempDir"      = "s3://${var.s3_bucket}/tmp/"
    "--output_path"  = "s3://${var.s3_bucket}/processed/"
    "--database"     = aws_glue_catalog_database.etl_db.name
    "--table_name"   = "${var.raw_prefix}raw"
  }
}

resource "aws_glue_crawler" "crawler_processed" {
  database_name = aws_glue_catalog_database.etl_db.name
  name          = "${var.pj_name}-crawler-processed"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${var.s3_bucket}/pocessed"
  }

  table_prefix = var.raw_prefix
}