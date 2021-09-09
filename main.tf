resource "aws_vpc" "vpc" {
  source = "./modules"
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"
  tags = {
    Name = "${var.product}.${var.environment}-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  source = "./modules"
  count      = length(split(",", var.public_subnets))
  vpc_id     = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block  = element(split(",", var.public_subnets), count.index)
  availability_zone = element(split(",", var.availability_zones), count.index)


  tags = {
    Name = "${var.product}.${var.environment}-public_subnets.${count.index + 1}"
  }
}
