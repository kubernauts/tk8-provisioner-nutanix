provider "nutanix" {
  username = "${var.username}"
  password = "${var.password}"
  endpoint = "${var.endpoint}"
  port     = "${var.port}"
  insecure = true
}

data "template_file" "init" {
template = "}"
}

## Network Resources
module "network" {
  source = "modules/network"
  cluster_id="${var.clusterid}"
  bastion-count="${var.bastion-count}"
  master-count="${var.master-count}"
  worker-count="${var.worker-count}"
  etcd-count="${var.etcd-count}"
}
## Compute Resources
module "compute" {
  source = "modules/compute"
  cluster_id="${var.clusterid}"
  bastion-subnet-id="${module.network.bastion-subnet-id}"
  kube-subnet-id="${module.network.kube-subnet-id}"
  image-id="${var.image-id}"
  bastion-count="${var.bastion-count}"
  master-count="${var.master-count}"
  worker-count="${var.worker-count}"
  etcd-count="${var.etcd-count}"
}

