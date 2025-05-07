terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
      version = "= 0.86.0"
      configuration_aliases = [snowflake.sysadmin]
    }
  }
}


resource "snowflake_schema" "demo_schema" {
  provider = snowflake.sysadmin
  name     = var.schema_name
  database = var.db_name
}

resource "snowflake_table" "logs" {
  provider = snowflake.sysadmin
  database = var.db_name
  schema   = var.schema_name
  name     = "logs"

  column {
    name = "id"
    type = "NUMBER"
  }

  column {
    name = "name"
    type = "STRING"
  }

  column {
    name = "created_at"
    type = "TIMESTAMP"
  }
}

resource "snowflake_storage_integration" "s3_int" {
  provider = snowflake.sysadmin
  name                      = "S3_TO_SNOWFLAKE"
  storage_provider          = "S3"
  storage_aws_role_arn      = var.iam_role
  storage_allowed_locations = ["s3://${var.aws_s3_bucket}/incoming/"]
  enabled                   = true
}

resource "snowflake_stage" "demo_stage" {
  provider = snowflake.sysadmin
  name                 = "DEMO_STAGE"
  database             = var.db_name
  schema               = var.schema_name
  url                  = "s3://${var.aws_s3_bucket}/incoming/"
  storage_integration  = snowflake_storage_integration.s3_int.name
}

resource "snowflake_pipe" "demo_pipe" {
  provider    = snowflake.sysadmin
  name        = "DEMO_PIPE"
  database    = var.db_name
  schema      = var.schema_name
  auto_ingest = true

  copy_statement = <<-EOT
    COPY INTO "${var.db_name}"."${var.schema_name}"."logs"
    FROM @"${var.db_name}"."${var.schema_name}"."DEMO_STAGE"
    FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER=1)
  EOT


  depends_on = [
    snowflake_table.logs,
    snowflake_stage.demo_stage
  ]
}
