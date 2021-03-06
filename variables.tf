variable "aws_region" {
  type    = string
  default = "af-south-1"
}

variable "tags" {
  default = {
    environment = "pitest"
  }
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "EC2 Tutorial"
}
