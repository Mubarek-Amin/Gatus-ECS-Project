
resource "aws_vpc" "gatus-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {

    Name = "gatus-vpc"
  }

}

resource "aws_subnet" "pub1" {
    
  vpc_id = var.vpc_id
}
resource "aws_subnet" "pub2" {

  vpc_id = var.vpc_id
}
resource "aws_subnet" "priv1" {

  vpc_id = var.vpc_id
}
resource "aws_subnet" "priv2" {

  vpc_id = var.vpc_id
}
resource "aws_route_table" "public"{
    vpc_id = var.vpc_id
}
resource "aws_route_table" "private-1"{
    vpc_id = var.vpc_id
}
resource "aws_route_table" "private-2"{
    vpc_id = var.vpc_id
}