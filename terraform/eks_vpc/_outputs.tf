output "private_subnet_ids" {
  value       = aws_subnet.private.*.id
  description = "List of private subnet IDs"
}

output "public_subnet_ids" {
  value       = aws_subnet.public.*.id
  description = "List of public subnet IDs"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID for VPC created"
}

output "all_subnet_ids" {
  value = concat(aws_subnet.private.*.id, aws_subnet.public.*.id)
  description = "List of all subnet IDs"
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}