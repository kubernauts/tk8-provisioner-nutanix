
variable "cluster_id" {
  
}

variable "bastion-count" {
    default=1
    description="amount of bastion server"
}
variable "master-count" {
    default=0
    description="amount of master server"
}
variable "worker-count" {
    default=0
    description="amount of worker server"
}
variable "etcd-count" {
    default=0
    description="amount of etcd server"
}