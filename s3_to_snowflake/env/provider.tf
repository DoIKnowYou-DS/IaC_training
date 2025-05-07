terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1"
    }
    snowflake = {
      source = "snowflakedb/snowflake"
      version = "= 0.86.0"
    }
  }

  backend "local" {
    path = "dev/local.tfstate"
  }

  required_version = "~> 1.11.4"
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "sts" # sts認証でデフォルトに設定していないため
}

provider "snowflake" {
  alias    = "sysadmin"
  account  = var.snowflake_account
  user     = var.snowflake_username
  role     = var.snowflake_role
  private_key            = file(var.snowflake_private_key_path)       
  private_key_passphrase = var.snowflake_private_key_passphrase
  authenticator = "JWT"
}
