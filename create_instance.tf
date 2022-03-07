   terraform {
      required_providers {
         hpegl = {
            source  = "hewlettpackard/hpegl"
            version = ">= 0.1.0-beta7"
         }
      }
   }

   provider "hpegl" {
      vmaas {
         location   = "HPE"
         space_name = "Default"
      }
   }

   data "hpegl_vmaas_datastore" "c_3par" {
      cloud_id = data.hpegl_vmaas_cloud.cloud.id
      name = "Compute-Cluster-Vol0"
   }

   data "hpegl_vmaas_network" "blue_net" {
     name = "Blue-Net"
   }
   
   data "hpegl_vmaas_network" "green_net" {
     name = "green-net"
   }
   
   data "hpegl_vmaas_group" "default_group" {
     name = "Default"
   }
   
   data "hpegl_vmaas_resource_pool" "cl_resource_pool" {
     cloud_id = data.hpegl_vmaas_cloud.cloud.id
     name = "ComputeResourcePool"
   }
   
   data "hpegl_vmaas_layout" "vmware" {
     name = "Vmware VM"
     instance_type_code = "vmware"
   }
   
   data "hpegl_vmaas_cloud" "cloud" {
     name = "HPE GreenLake VMaaS Cloud-Trial1"
   }
   
   data "hpegl_vmaas_plan" "g1_small" {
     name = "G1-Small"
   }
   
   data "hpegl_vmaas_power_schedule" "weekday" {
     name = "DEMO_WEEKDAY"
   }
   
   data "hpegl_vmaas_template" "vanilla" {
     name = "vanilla-centos7-x86_64-09072020"
   }
   
   data "hpegl_vmaas_environment" "dev" {
     name = "Dev"
   }

   resource "hpegl_vmaas_instance" "quick_guide_instance" {
     name               = "quick_guide_instance"
     cloud_id           = data.hpegl_vmaas_cloud.cloud.id
     group_id           = data.hpegl_vmaas_group.default_group.id
     layout_id          = data.hpegl_vmaas_layout.vmware.id
     plan_id            = data.hpegl_vmaas_plan.g1_small.id
     instance_type_code = data.hpegl_vmaas_layout.vmware.instance_type_code

     network {
         id = data.hpegl_vmaas_network.blue_net.id
     }

     volume {
         name         = "root_vol"
         size         = 10
         datastore_id = data.hpegl_vmaas_datastore.c_3par.id
         root         = true
     }

     config {
         resource_pool_id = data.hpegl_vmaas_resource_pool.cl_resource_pool.id
         template_id      = data.hpegl_vmaas_template.vanilla.id
         no_agent         = true
         create_user      = false
         asset_tag        = "vm_tag"
     }

     power = "poweron"
   }
