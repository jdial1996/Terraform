resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Only need kubernetes.io/role/elb tags if you intend to deploy load balancers into these subnets (needed for aws lb controller?)

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  for_each          = var.public_subnet_cidrs
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name                                        = "public-${each.key}"
    "kubernetes.io/role/elb"                    = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}


resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  for_each          = var.private_subnet_cidrs
  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name                                        = "private-${each.key}"
    "kubernetes.io/role/internal-elb"           = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "karpenter.sh/discovery" = var.cluster_name
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc" # Set to vpc if EIP is being used in a vpc 
}

# TODO: If prod, create a nat gateway in each AZ, if not just create a single nat gateway 

resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.public["eu-west-2a"].id
  allocation_id = aws_eip.nat_eip.id
  tags = {
    Environment = var.environment
  }
}


# Routes tables

# Private 

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
}

# Public

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

