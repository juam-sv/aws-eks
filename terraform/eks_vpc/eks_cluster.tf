resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_role.arn

  version = var.eks_version

  vpc_config {
    subnet_ids         = local.all_subnet_ids
    # security_group_ids = var.cluster_security_group_id
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access = var.endpoint_public_access
  }
  tags = merge(
    var.tags,
    {
      Name = var.eks_cluster_name
    }
  )
}

resource "aws_iam_role" "eks_role" {
  name = "${var.eks_cluster_name}-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}