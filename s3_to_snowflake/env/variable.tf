# Snowflake用変数
variable "snowflake_account" {
  description = "Snowflake account identifier (e.g., on44798)"
  type        = string
}

variable "snowflake_username" {
  description = "Snowflake username (e.g., ryota.doi)"
  type        = string
}


variable "snowflake_role" {
  description = "Snowflake role to assume (e.g., SYSTEMADMIN)"
  type        = string
}

variable "snowflake_private_key_path" {}

variable "snowflake_private_key_passphrase" {}