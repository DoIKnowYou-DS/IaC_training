terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1"
    }
  }

  backend "local" {
    path = "dev/local.tfstate"
  }
  required_version = "~> 1.11.4"
}

provider "aws" {
  # Configuration options
  region = "ap-northeast-1"
  profile = "sts" # sts認証でデフォルトに設定していないため
}