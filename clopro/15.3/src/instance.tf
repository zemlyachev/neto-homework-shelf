# -------------------------- Instance --------------------------
# Instance group for network load balancer
resource "yandex_iam_service_account" "sa-group" {
  name = "sa-group"
}

resource "yandex_resourcemanager_folder_iam_member" "roleassignment-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-group.id}"
}

resource "yandex_compute_instance_group" "instance-group" {
  name               = "instance-group"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.sa-group.id
  depends_on         = [yandex_resourcemanager_folder_iam_member.roleassignment-editor]
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }
    network_interface {
      network_id = yandex_vpc_network.network-netology.id
      subnet_ids = [yandex_vpc_subnet.public.id]
    }
    metadata = {
      ssh-keys  = local.ubuntu_ssh_key
      user-data = "#!/bin/bash\n cd /var/www/html\n echo \"<html><h1>The netology web-server with a network load balancer.</h1><img src='https://${yandex_storage_bucket.public-image.bucket_domain_name}/${yandex_storage_object.pedro-pedro-pedro.key}'></html>\" > index.html"
    }
    labels = {
      group = "instance-group"
    }
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }
  allocation_policy {
    zones = [var.default_zone]
  }
  deploy_policy {
    max_unavailable = 2
    max_expansion   = 1
  }
  load_balancer {
    target_group_name = "target-instance-group"
  }
  health_check {
    interval            = 15
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    http_options {
      path = "/"
      port = 80
    }
  }
}

# Network Load balancer
resource "yandex_lb_network_load_balancer" "instance-group-load-balancer" {
  name = "instance-group-load-balancer"
  listener {
    name = "instance-group-load-balancer-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_compute_instance_group.instance-group.load_balancer.0.target_group_id
    healthcheck {
      name                = "http"
      interval            = 10
      timeout             = 5
      healthy_threshold   = 5
      unhealthy_threshold = 2
      http_options {
        path = "/"
        port = 80
      }
    }
  }
}
