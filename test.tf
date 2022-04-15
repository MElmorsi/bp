#  Set-up for terraform >= v0.13
terraform {
  required_providers {
    hpegl = {
      source = "registry.terraform.io/hewlettpackard/hpegl"
      #      version = ">= 0.0.1"
      version = "0.1.0-beta7"
    }
  }
}




variable "location" {
  description = "Tenant location"
  type        = string
  default     = "HPE"
}

variable "space" {
  description = "space"
  type        = string
  default     = "Default"
}

variable "cloud" {
  description = "cloud"
  type        = string
  default     = "HPE GreenLake VMaaS Cloud-Trial4"
}


variable "group" {
  description = "group"
  type        = string
  default     = "Default"
}

provider "hpegl" {
  vmaas {
    location   = var.location
    space_name = var.space
  }
}

data "hpegl_vmaas_cloud" "cloud" {
  name = var.cloud
}



data "hpegl_vmaas_group" "terraform_group" {
  name = var.group
}
