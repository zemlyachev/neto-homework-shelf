locals {
  cores = 2
  memory = 4
  image_id = "fd8hedriopd1p208elrg" #Centos7
  platform_id = "standard-v1"
  ssh-keys = "cloud-user:${file("~/.ssh/id_rsa.pub")}"
  names = ["jenkins-master", "jenkins-agent"]
}

resource "yandex_compute_instance" "instance" {
  name = local.names[count.index]
  platform_id = local.platform_id

  count = length(local.names)

  resources {
    cores  = local.cores
    memory = local.memory
  }

  boot_disk {
    initialize_params {
      image_id = local.image_id 
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = local.ssh-keys
    serial-port-enable = 1
  }
}

resource "yandex_vpc_network" "network" {
  name = "main_network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "main_subnet"
  v4_cidr_blocks = ["10.2.0.0/24"]
  network_id     = yandex_vpc_network.network.id
}