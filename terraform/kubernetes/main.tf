variable "cluster_name" {
  type    = string
  default = "peerdas"
}

variable "region" {
  type    = string
  default = "ams3" # list available regions with `doctl compute region list`
}

locals {
  cluster_name = format("%s-%s", var.cluster_name, var.region)
  common_tags  = [local.cluster_name, "peerdas-cluster", "owner:barnabasbusa"]
}

