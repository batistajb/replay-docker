locals {
  cluster_name = "replay-app-cluster-${var.tags["Env"]}"
}
variable "tags" { }
