variable "bastion-count" {
    default=1
    description="amount of bastion server"
}
variable "master-count" {
    default=1
    description="amount of master server"
}
variable "worker-count" {
    default=1
    description="amount of worker server"
}
variable "etcd-count" {
    default=1
    description="amount of etcd server"
}
variable "cluster_id" {
  
}

variable "kube-subnet-id" {
  
}

variable "bastion-subnet-id" {
  
}

variable "image-id" {
  default=""
}
