variable "subnetpublicid" {
    type = string
  
}

variable "vpcid" {
    type = string
  
}


variable "instance_type" {
    type = string
    default = "t3.medium"
}

variable "ami" {
    type = string
    default = "ami-04b70fa74e45c3917"
}
