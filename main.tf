terraform {
  required_providers {
    hpegl = {
      source = "HewlettPackard/hpegl"
      version = "0.1.0-beta6"
    }
  }
}

provider "hpegl" {
  vmaas {
    location   = "HPE"
    space_name = "Default"
  }
}

data "hpegl_vmaas_group" "terraform_group" {
  name = "Default"
}

output "group" {
  value = data.hpegl_vmaas_group.terraform_group.id
}
