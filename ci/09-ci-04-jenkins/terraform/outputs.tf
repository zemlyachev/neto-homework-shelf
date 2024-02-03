output "external_ip" {
  value = {for inst in yandex_compute_instance.instance: inst.name => inst.network_interface.0.nat_ip_address}
}