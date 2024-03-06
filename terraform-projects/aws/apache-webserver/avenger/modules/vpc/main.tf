resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}_vpc"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {

    Name = "${var.project_name}_internet_gateway"
  }
}



resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.project_name}_routing_table"
  }
}

data "aws_availability_zones" "available_zones" {}


resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = {
    Name = "${var.project_name}-subnet-1"
  }
}


resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route-table.id
}
