# VPC
resource "yandex_vpc_network" "network-netology" {
  name = "network-netology"
}


# ----------------------------------------- PUBLIC SUBNET -----------------------------------------

## Public subnet
resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network-netology.id
  v4_cidr_blocks = var.public_cidr
}

# NAT instance
resource "yandex_compute_instance" "nat-instance" {
  name     = "nat-instance"
  hostname = "nat-instance"
  zone     = var.default_zone
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.nat_ubuntu_image_id
    }
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ip_address = var.nat_instance_ip
    nat        = true
  }
  metadata = {
    ssh-keys = local.ubuntu_ssh_key
  }
}

# Public instance
resource "yandex_compute_instance" "public-instance" {
  name     = "public-instance"
  hostname = "public-instance"
  zone     = var.default_zone
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }
  metadata = {
    ssh-keys = local.ubuntu_ssh_key
  }
}

# ----------------------------------------- PRIVATE SUBNET -----------------------------------------

# Private subnet
resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network-netology.id
  route_table_id = yandex_vpc_route_table.netology-routing.id
  v4_cidr_blocks = var.private_cidr
}

# Routing table
resource "yandex_vpc_route_table" "netology-routing" {
  name       = "netology-routing"
  network_id = yandex_vpc_network.network-netology.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface[0].ip_address
  }
}

# Private instance
resource "yandex_compute_instance" "private-instance" {
  name     = "private-instance"
  hostname = "private-instance"
  zone     = var.default_zone
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image_id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }
  metadata = {
    ssh-keys = local.ubuntu_ssh_key
  }
}

