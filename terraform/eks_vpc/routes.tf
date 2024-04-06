resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.tags,
    {
    Name = "PublicRouteTable"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = var.public_subnet_number
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private.id
  }

  tags = merge(
    var.tags,
    {
      Name = "PrivateRouteTable"
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = var.private_subnet_number
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}