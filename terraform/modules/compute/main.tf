resource "nutanix_image" "CentOS" {
  count="${var.image-id == "" ? 1 : 0 }"

  name="CentOS"
  description="Contos cloud image"
  source_uri="https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
}

locals {
    image-id = "${element(concat(nutanix_image.CentOS.*.id, list("")),0)}"
}

resource "nutanix_virtual_machine" "bastion" {
    count="${var.bastion-count}"
    name="bastion-${count.index}"
    description          = "Bastion Server"
    num_vcpus_per_socket = 2
    num_sockets          = 1
    memory_size_mib      = 4096
    power_state          = "ON"
    cluster_reference = {
        kind = "cluster"
        uuid = "${var.cluster_id}"
    }
    nic_list =[{
        subnet_reference={
            kind="subnet"
            uuid="${var.bastion-subnet-id}"
        }
    }]
    disk_list = [{
     data_source_reference = [{
       kind = "image"      
       uuid = "${var.image-id != "" ? var.image-id : local.image-id}"
     }]
     disk_size_mib = 50000
   }]
   guest_customization_cloud_init_user_data = "${base64encode(file("cloud-init.conf"))}"
}

resource "nutanix_virtual_machine" "master" {
    count="${var.master-count}"
    name="master-${count.index}"
    description          = "Kube Master Server"
    num_vcpus_per_socket = 2
    num_sockets          = 1
    memory_size_mib      = 4096
    power_state          = "ON"
    cluster_reference = {
        kind = "cluster"
        uuid = "${var.cluster_id}"
    }
    nic_list =[{
        subnet_reference={
            kind="subnet"
            uuid="${var.kube-subnet-id}"
        }
    }]
    disk_list = [{
     data_source_reference = [{
       kind = "image"      
       uuid = "${var.image-id == "" ? local.image-id : var.image-id}"
     }]
     disk_size_mib = 50000
   }]
   guest_customization_cloud_init_user_data = "${base64encode(file("cloud-init.conf"))}"
}
resource "nutanix_virtual_machine" "worker" {
    count="${var.worker-count}"
    name="worker-${count.index}"
    description          = "Kube Worker Server"
    num_vcpus_per_socket = 2
    num_sockets          = 1
    memory_size_mib      = 4096
    power_state          = "ON"
    cluster_reference = {
        kind = "cluster"
        uuid = "${var.cluster_id}"
    }
    nic_list =[{
        subnet_reference={
            kind="subnet"
            uuid="${var.kube-subnet-id}"
        }
    }]
    disk_list = [{
     data_source_reference = [{
       kind = "image"      
       uuid = "${var.image-id == "" ? local.image-id : var.image-id}"
     }]
     disk_size_mib = 50000
   }]
   guest_customization_cloud_init_user_data = "${base64encode(file("cloud-init.conf"))}"
}

resource "nutanix_virtual_machine" "etcd" {
    count="${var.etcd-count}"
    name="etcd-${count.index}"
    description          = "Kube Etcd Database"
    num_vcpus_per_socket = 2
    num_sockets          = 1
    memory_size_mib      = 4096
    power_state          = "ON"
    cluster_reference = {
        kind = "cluster"
        uuid = "${var.cluster_id}"
    }
    nic_list =[{
        subnet_reference={
            kind="subnet"
            uuid="${var.kube-subnet-id}"
        }
    }]
    disk_list = [{
     data_source_reference = [{
       kind = "image"      
       uuid = "${var.image-id == "" ? local.image-id : var.image-id}"
     }]
     disk_size_mib = 50000
   }]
   guest_customization_cloud_init_user_data = "${base64encode(file("cloud-init.conf"))}"
}