# minimal instance creation
resource "hpegl_vmaas_instance_clone" "terrforminstancetest" {
  name               = "tf_minimal_clone"
  source_instance_id = hpegl_vmaas_instance.tf_instance.id
  network {
    id = data.hpegl_vmaas_network.Blue-Netowrk.id
  }
}
