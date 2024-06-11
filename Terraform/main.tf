provider "aws" {
  region  = var.region
  profile = "default"
}
module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_az   = var.public_subnet_az
  vpc_name           = var.vpc_name
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.network.subnet_id
  vpc_id        = module.network.vpc_id
  sg            = var.sg
  key_name      = var.key_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  log_group_name                = var.log_group_name
  log_group_retention_in_days   = var.log_group_retention_in_days
  log_stream_name               = var.log_stream_name
  alarm_name                    = var.alarm_name
  alarm_comparison_operator     = var.alarm_comparison_operator
  alarm_evaluation_periods      = var.alarm_evaluation_periods
  alarm_metric_name             = var.alarm_metric_name
  alarm_namespace               = var.alarm_namespace
  alarm_period                  = var.alarm_period
  alarm_statistic               = var.alarm_statistic
  alarm_threshold               = var.alarm_threshold
  instance_id                   = module.ec2.ec2_id
  sns_topic_name                = var.sns_topic_name
  sns_email                     = var.sns_email
}

resource "local_file" "private_key" {
  content    = tls_private_key.myprivatekey.private_key_pem
  filename   = "../Ansible/private_key.pem"
  depends_on = [module.ec2]
}

resource "null_resource" "set_permissions" {
  provisioner "local-exec" {
    command = "chmod 400 ../Ansible/private_key.pem"
  }

  depends_on = [local_file.private_key]
}