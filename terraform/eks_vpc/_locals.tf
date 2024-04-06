locals {
  all_subnet_ids = flatten([
    aws_subnet.private.*.id,
    aws_subnet.public.*.id
  ])
}