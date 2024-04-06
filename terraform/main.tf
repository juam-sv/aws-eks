provider "aws" {
  region = try(local.workspace.region, "us-east-1")
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
}

module "eks" {
  for_each                = { for eks in local.workspace.eks : eks.name => eks }
  # count  = local.workspace.eks.enabled ? 1 : 0
  source = "./eks_vpc"

  eks_cluster_name = each.value.name
  eks_version = try(each.value.version, "1.28")

  vpc_cidr = try(each.value.vpc_cidr, "10.0.0.0/16")
  endpoint_private_access = try(each.value.endpoint_private_access, true)
  endpoint_public_access = try(each.value.endpoint_public_access, true)

  scale_desire = try(each.value.scale_desire, 1)
  scale_min = try(each.value.scale_min, 1)
  scale_max = try(each.value.scale_max, 1)

  capacity_type = try(each.value.capacity_type, "SPOT")
  disk_size = try(each.value.disk_size, 20)
  instance_types = try(each.value.instance_types, ["t3.small"])

  tags      = try(each.value.tags)
}

