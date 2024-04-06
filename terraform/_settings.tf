locals {
  env       = yamldecode(file("./config.yaml"))
  workspace = local.env["workspaces"][terraform.workspace]
}