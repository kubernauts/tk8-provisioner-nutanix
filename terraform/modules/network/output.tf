output "bastion-subnet-id" {
  value = "${local.bastion-subnet}"
}
output "kube-subnet-id" {
  value = "${local.kube-subnet}"
}
