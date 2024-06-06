# Output
output "external_ip_address_public" {
  value = yandex_compute_instance.public-instance.network_interface.0.nat_ip_address
}

output "external_ip_address_nat" {
  value = yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address
}

output "instance-group_ip_address" {
  value = yandex_compute_instance_group.instance-group.instances[*].network_interface[0].ip_address
}

output "instance-group-load-balancer_address" {
  value = yandex_lb_network_load_balancer.instance-group-load-balancer.listener.*.external_address_spec[0].*.address
}

output "image_url" {
  value = "https://${yandex_storage_bucket.public-image.bucket_domain_name}/${yandex_storage_object.pedro-pedro-pedro.key}"
}
