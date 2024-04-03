variable "region" {
  default = "us-east-1"
}
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