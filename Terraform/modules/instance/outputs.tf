


output "security_group_ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
   
}

output "public_ip" {
  value = aws_instance.web.public_ip
   
}
