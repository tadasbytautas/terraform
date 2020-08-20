provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = "VPC190820"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.sn_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.subnet_a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.allow_tls.id}"]
}

resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.route.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# resource "aws_security_group" "sg_web" {
#   name var.sg_web_name
#   description = var.sg_web_description

#   vpc_id = aws_vpc.vpc.id

#   dynamic "ingress" {
#     iterator = protocol
#     for_each = var.ingress_ports
#     content {
#       from_port = port.value
#       protocol = "tcp"
#       to_port = port.value
#       cidr_block = [var.open_internet]

#     }
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
