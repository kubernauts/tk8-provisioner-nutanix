variable "username" {
    description="nutanix AHV username"
}
variable "password" {
  description="nutanix AHV password"
}

variable "endpoint" {
  description="nutanix AHV Host"
}

variable "port" {
  description="nutanix AHV port"
}

variable "clusterid" {
  description="nutanix cluster id"
}

variable "image-id" {
  default=""
  
}

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
