resource "digitalocean_vpc" "peerdas" {
  name     = local.cluster_name
  region   = var.region
  ip_range = "10.221.0.0/16"
}

resource "digitalocean_project" "peerdas" {
  name        = "Peerdas-devnets"
  description = "Peerdas-devnets testing infrastructure"
  purpose     = "Other"
  environment = "Development"
}

resource "digitalocean_project_resources" "peerdas" {
  project = digitalocean_project.peerdas.id

  resources = [
    digitalocean_kubernetes_cluster.peerdas.urn,
  ]
}


resource "digitalocean_kubernetes_cluster" "peerdas" {
  name     = local.cluster_name
  region   = var.region
  version  = "1.31.1-do.0"
  vpc_uuid = digitalocean_vpc.peerdas.id
  tags     = local.common_tags

  lifecycle {
    ignore_changes = [
      node_pool[0].node_count,
      node_pool[0].nodes,
    ]
  }

  node_pool {
    name       = "${local.cluster_name}-default"
    size       = "s-8vcpu-16gb-amd" # $320/month,  list available options with `doctl compute size list`
    labels     = {}
    node_count = 15
    auto_scale = true
    max_nodes  = 15
    min_nodes  = 15
    tags       = concat(local.common_tags, ["default"])
  }
}
