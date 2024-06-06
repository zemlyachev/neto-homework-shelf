resource "yandex_kms_symmetric_key" "encryptkey" {
  name              = "encryptkey"
  default_algorithm = "AES_256"
}

// Grant permissions use key
resource "yandex_resourcemanager_folder_iam_member" "kms-user" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [yandex_iam_service_account.sa-bucket]
}
