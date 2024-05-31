# -------------------------- Bucket --------------------------
# Bucket service account
resource "yandex_iam_service_account" "sa-bucket" {
  name = "sa-bucket"
}

# Bucket service account role storage.editor
resource "yandex_resourcemanager_folder_iam_member" "roleassignment-storageeditor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
}

# Bucket service account access key
resource "yandex_iam_service_account_static_access_key" "accesskey-bucket" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
}

# Public bucket
resource "yandex_storage_bucket" "public-image" {
  access_key            = yandex_iam_service_account_static_access_key.accesskey-bucket.access_key
  secret_key            = yandex_iam_service_account_static_access_key.accesskey-bucket.secret_key
  bucket                = "public-image"
  default_storage_class = "STANDARD"
  acl                   = "public-read"
  force_destroy         = "true"
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
}

# Add object
resource "yandex_storage_object" "pedro-pedro-pedro" {
  access_key = yandex_iam_service_account_static_access_key.accesskey-bucket.access_key
  secret_key = yandex_iam_service_account_static_access_key.accesskey-bucket.secret_key
  bucket     = yandex_storage_bucket.public-image.id
  key        = "pedro.gif"
  source     = "files/pedro.gif"
}
