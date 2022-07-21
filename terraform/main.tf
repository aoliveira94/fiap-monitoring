resource "google_container_cluster" "primary" {
  name               = var.name_cluster
  location           = var.region
  initial_node_count = var.numeric_pool
  node_locations     = ["us-central1-a"]

  node_config {
    preemptible  = true
    machine_type = var.vm_intance
    disk_size_gb = var.size_disk
    disk_type    = var.type_disk
  }
}
