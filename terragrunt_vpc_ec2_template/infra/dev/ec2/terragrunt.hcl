
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t2.micro"
  subnet_id     = "${dependency.vpc.outputs.vpc_id}"
  region     = "ap-northeast-1"
  profile    = "sts"
}
