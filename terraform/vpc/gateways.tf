resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MainInternetGateway"
  }
}

resource "aws_nat_gateway" "private" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.private[0].id
}

resource "aws_eip" "nat" {
  vpc    = true
}

resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private.id
}
