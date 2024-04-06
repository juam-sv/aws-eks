variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_number" {
  description = ""
  default     = 3
}

variable "private_subnet_number" {
  description = ""
  default     = 3
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to attach to resources"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "eks_version" {
  type = string
  default = "1.27"
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "Lista de IDs das subnets"
}

variable "cluster_security_group_id" {
  type = list(string)
  default = [""]
}

variable "eks_cluster_name" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
  default = true
}

variable "endpoint_public_access" {
  type = bool
  default = true
}

variable "scale_desire" {
  type = number
  default = 1
}
variable "scale_min" {
  type = number
  default = 0
}
variable "scale_max" {
  type = number
  default = 3
}
variable "capacity_type" {
  type = string
  default = "ON_DEMAND"
}
variable "instance_types" {
  type = list(string)
  default = [ "t3.small", "t3.medium" ]
}
variable "disk_size" {
  type = number
  default = 20 
}