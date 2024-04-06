resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "MainInternetGateway"
    }
  )
}

resource "aws_nat_gateway" "private" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.private[0].id
  tags = merge(
    var.tags,
    {
      Name = "NATGW"
    }
  )
  depends_on = [ aws_eip.nat ]
}

resource "aws_eip" "nat" {
  vpc    = true
  tags = merge(
    var.tags,
    {
      Name = "EIP"
    }
  )
}