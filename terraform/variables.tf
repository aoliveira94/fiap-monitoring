variable "region" {
  type    = string
  default = "us-central1"
}
variable "project" {
  type    = string
  default = "infra-324113"
}

variable "email" {
  type    = string
  default = "adriano.muniz@outlook.com.br"
}

variable "credentials" {
  type    = string
  default = "~/.config/gcloud/application_default_credentials.json"
}

variable "vm_intance" {
  type    = string
  default = "e2-standard-4"
}

variable "name_cluster" {
  type    = string
  default = "devops-monitoring"
}

variable "numeric_pool" {
  type    = string
  default = "1"
}

variable "size_disk" {
  type    = string
  default = "100"
}

variable "type_disk" {
  type    = string
  default = "pd-standard"
}