locals {
  bastion-subnet = "${element(concat(nutanix_subnet.bastion-subnet.*.id,list("")),0)}"
  kube-subnet = "${element(concat(nutanix_subnet.kube-subnet.*.id,list("")),0)}"
}

resource "nutanix_subnet" "bastion-subnet" {
    count="${var.bastion-count > 0?1:0}"
    cluster_reference = {
        kind = "cluster"
        uuid = "${var.cluster_id}"
    }
    name="bastion-subnet"
    vlan_id=1
    subnet_type="VLAN"  
    default_gateway_ip = "10.21.52.1"
    subnet_ip = "10.21.52.0"
    prefix_length= 24
    ip_config_pool_list_ranges= [
        "10.21.52.100",
        "10.21.52.109"
    ]
    dhcp_server_address={
        ip="10.21.52.254"
    }
    dhcp_options {
		boot_file_name   = "bootfile"
		domain_name      = "nutanix"
		tftp_server_name = "10.21.52.200"
  }
  dhcp_domain_name_server_list = ["8.8.8.8", "4.2.2.2"]
}

resource "nutanix_subnet" "kube-subnet" {
    count="${var.master-count > 0||var.worker-count > 0|| var.etcd-count > 0 ? 1 :0 }"
    cluster_reference = {
        kind = "cluster"
        uuid = "${var.cluster_id}"
    }
    name="kube-subnet"
    vlan_id=2
    subnet_type="VLAN"  
    default_gateway_ip = "10.21.52.1"
    subnet_ip = "10.21.52.0"
    prefix_length= 24
    ip_config_pool_list_ranges= [
        "10.21.52.110",
        "10.21.52.250"
    ]
    dhcp_server_address={
        ip="10.21.52.254"
    }
    dhcp_options {
		boot_file_name   = "bootfile"
		domain_name      = "nutanix"
		tftp_server_name = "10.21.52.200"
  }
  dhcp_domain_name_server_list = ["8.8.8.8", "4.2.2.2"]
}