provider "aws" {
          region = var.region
          profile = "default"
#           access_key = "my-access-key"
#   secret_key = "my-secret-key"
}
terraform {
    backend "s3" {
        bucket         = "ivolve-statefilee"
        key            = "terraform.tfstate"
        region         = "us-east-1"
        dynamodb_table = "IVolve-Locks"
        encrypt        = true
    }
}


module "ec2" {

    source                 =   "./modules/instance"
    vpcid                  =   module.vpc.vpc_id
    subnetpublicid         =   module.vpc.subnet_public_id
    ami                    =   var.ami
    instance_type          =   var.instance_type
# output puplic ip module.ec2.public_ip
}

module "vpc" {

    source                  =   "./modules/vpc"
    vpc_cidr                =   var.vpc_cidr
    public_subnet_cidr      =  var.public_cidr 
    private_subnet_cidr     = var.private_cidr 
    
  
}



