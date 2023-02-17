# Create VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = var.vpc_name
  }
}

# Create public subnets
resource "aws_subnet" "public" {
  count                   = 3
  cidr_block              = "10.0.${count.index + 1}.0/24"
  vpc_id                  = aws_vpc.example.id
  map_public_ip_on_launch = true
  availability_zone       = var.azs[count.index]
  tags = {
    "Name" = "public-subnet-ALB-${count.index + 1}"
  }
}

# Create private subnets for app
resource "aws_subnet" "app" {
  count             = 3
  cidr_block        = "10.0.${count.index + 10}.0/24"
  vpc_id            = aws_vpc.example.id
  availability_zone = var.azs[count.index]
  tags = {
    "Name" = "private-subnet-Ec2-${count.index}"
  }
}

# Create private subnets for database
resource "aws_subnet" "db" {
  count             = 3
  cidr_block        = "10.0.${count.index + 20}.0/24"
  vpc_id            = aws_vpc.example.id
  availability_zone = var.azs[count.index]
  tags = {
    "Name" = "private-subnet-RDS-${count.index}"
  }
}

# Create internet gateway and attach to VPC
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.example.id
  tags = {
    "WP_gateway" = "value"
  }
}

# Create route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    "Name" = "ALB_route_table"
  }
}

# Create route table for private app subnets
resource "aws_route_table" "app" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    "Name" = "app_route_table"
  }
}

# Create route table for private database subnets
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.example.id
  tags = {
    "Name" = "Database_route_table"
  }
}

# Create an Elastic IP
resource "aws_eip" "nat" {
  vpc = true
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate app subnets with app route table
resource "aws_route_table_association" "app" {
  count          = 3
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app.id
  depends_on = [
    aws_nat_gateway.nat
  ]
}

# Associate db subnets with db route table
resource "aws_route_table_association" "db" {
  count          = 3
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db.id
}

