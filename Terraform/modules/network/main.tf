resource "aws_vpc" "vpc" {
    cidr_block       = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
    Name = var.vpc_name
    }
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.public_subnet_az
  
  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name: "${var.vpc_name}-igw"
    }
}
resource "aws_route_table" "igw-rtw" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name: "${var.vpc_name}-rtb-public"
    }
}
resource "aws_route_table_association" "rtb_igw_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.igw-rtw.id
}