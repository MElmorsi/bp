# (C) Copyright 2021 Hewlett Packard Enterprise Development LP

# minimal instance creation

data "hpegl_vmaas_cloud" "cloud" {
  name = "HPE GreenLake VMaaS Cloud-Trial1"
}

data "hpegl_vmaas_group" "default_group" {
  name = "Default"
}

data "hpegl_vmaas_layout" "vmware_centos" {
  name               = "VMware VM with vanilla CentOS"
  instance_type_code = "glhc-vanilla-centos"
}

data "hpegl_vmaas_plan" "g1_small" {
  name = "G1-Small"
}

data "hpegl_vmaas_datastore" "c_3par" {
  cloud_id = data.hpegl_vmaas_cloud.cloud.id
  name     = "Compute-3par-A64G-FC-1TB"
}

data "hpegl_vmaas_resource_pool" "cluster" {
  cloud_id = data.hpegl_vmaas_cloud.cloud.id
  name     = "Cluster"
}

data "hpegl_vmaas_cloud_folder" "compute_folder" {
  cloud_id = data.hpegl_vmaas_cloud.cloud.id
  name     = "ComputeFolder"
}

data "hpegl_vmaas_network" "blue_net" {
  name = "Blue-Net"
}

data "hpegl_vmaas_resource_pool" "cluster" {
  cloud_id = data.hpegl_vmaas_cloud.cloud.id
  name     = "Cluster"
}

data "hpegl_vmaas_environment" "dev" {
  name = "dev"
}

resource "hpegl_vmaas_instance" "minimal_instance" {
  name               = "tf_minimal"
  cloud_id           = data.hpegl_vmaas_cloud.cloud.id
  group_id           = data.hpegl_vmaas_group.default_group.id
  layout_id          = data.hpegl_vmaas_layout.vmware_centos.id
  plan_id            = data.hpegl_vmaas_plan.g1_small.id
  instance_type_code = data.hpegl_vmaas_layout.vmware_centos.instance_type_code
  network {
    id = data.hpegl_vmaas_network.blue_net.id
  }

  volume {
    name         = "root_vol"
    size         = 5
    datastore_id = data.hpegl_vmaas_datastore.c_3par.id
  }

  config {
    resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
    folder_code      = data.hpegl_vmaas_cloud_folder.compute_folder.code
  }
  environment_code = data.hpegl_vmaas_environment.dev.code
}
