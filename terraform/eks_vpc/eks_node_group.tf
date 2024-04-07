resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.eks_cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  version = var.eks_version

  subnet_ids             = aws_subnet.private.*.id
  # subnet_ids             = local.all_subnet_ids
  scaling_config {
    desired_size = var.scale_desire
    max_size     = var.scale_max
    min_size     = var.scale_min
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
}
  labels = {
    role = "nodes-general"
  }

  ami_type = "AL2_x86_64"
  capacity_type = var.capacity_type
  disk_size = var.disk_size
  instance_types = var.instance_types

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_ec2_policy_attachment,
    aws_eks_cluster.eks_cluster
  ]
  tags = merge(
    var.tags,
    {
    Name = "${var.eks_cluster_name}-node-group"
    }
  )
}

resource "aws_iam_role" "eks_node_role" {
  name = "${var.eks_cluster_name}-eks-node-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
  tags = var.tags
}
resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_ec2_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}