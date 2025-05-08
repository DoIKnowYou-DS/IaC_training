
locals {
  region = "ap-northeast-1"
}

remote_state {
  backend = "local"
  config = {
    path = "terraform.tfstate"
  }
}

terraform {
  extra_arguments "region" {
    commands = ["apply", "plan", "destroy", "import"]
    arguments = ["-var", "region=${local.region}"]
  }
}
