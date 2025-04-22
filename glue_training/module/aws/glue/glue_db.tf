resource "aws_glue_catalog_database" "etl_db" {
  name = "${var.env_name}-${var.pj_name}-elt-db"
}