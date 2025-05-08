
variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}