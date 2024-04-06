resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags = merge(
    var.tags,
    {
    Name = "${var.eks_cluster_name}-eks-vpc"
    }
  )
}