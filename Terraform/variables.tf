variable "region" {
  default = "us-east-1"
}


variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "public_cidr" {
  default = "10.0.1.0/24"

}
variable "private_cidr" {
  default = "10.0.2.0/24"

}


variable "instance_type" {
    type = string
    default = "t3.medium"
}

variable "ami" {
    type = string
    default = "ami-04b70fa74e45c3917"
}
