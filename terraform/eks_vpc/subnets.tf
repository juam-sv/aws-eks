resource "aws_subnet" "public" {
  count                   = var.public_subnet_number
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  
  tags = merge(
    var.tags,
    {
      "Name"   = "Subnet-Public-${upper(data.aws_availability_zone.az[count.index].name_suffix)}"
      "Scheme" = "Public"
      "kubernetes.io/cluster/${var.eks_cluster_name}"       = "shared"
      "kubernetes.io/role/elb"    = 1
    }
  )
}

resource "aws_subnet" "private" {
  count             = var.private_subnet_number
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 3) # Desloca a indexação para não haver conflito com as sub-redes públicas
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  tags = merge(
    var.tags,
    {
      "Name"   = "Subnet-Private-${upper(data.aws_availability_zone.az[count.index].name_suffix)}"
      "Scheme" = "private"
      "kubernetes.io/cluster/${var.eks_cluster_name}"       = "shared"
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}