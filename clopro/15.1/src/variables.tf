# YC config variables
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# Public subnet variables
variable "public_cidr" {
  type = list(string)
  default = ["192.168.10.0/24"]
}

variable "nat_instance_ip" {
  type = string
  default = "192.168.10.254"
}

# Private subnet variables
variable "private_cidr" {
  type = list(string)
  default = ["192.168.20.0/24"]
}

# Common variables
variable "ubuntu_image_id" {
  type        = string
  default     = "fd85an6q1o26nf37i2nl"
  description = "ubuntu-20-04-lts-v20231218"
}

variable "nat_ubuntu_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
  description = "nat-instance-ubuntu-1559218207"
}
