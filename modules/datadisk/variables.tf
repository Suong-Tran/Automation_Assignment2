variable "rg" {
  default = "" 
}

variable "location" {
  default = ""
}

locals {
  common_tags = {
    Name      = "Automation Project - Assignment2"
    GroupMembers         = "Suong.Tran"
    GroupMembers         = "Afoke.Oghenekowho"
    ExpirationDate = "2022-08-20"
    Environment  = "Lab"
  }
}


variable "linux_name" { 
  type    = map(string)
  default = {}
}

variable "windows_name" {
  default = ""
}

variable "linux_virtual_machine_ids" {
  default = ""
}

variable "window_virtual_machine_ids" {
  default = ""
}

variable "disk_iops_read_write" {
  type    = number
  default = null
}

variable "disk_mbps_read_write" {
  type    = number
  default = null
}

variable "disk_size_gb" {
  type    = number
  default = null
}

variable "os_type" {
  type    = string
  default = null
}

variable "source_resource_id" {
  type    = string
  default = null
}

variable "source_uri" {
  type    = string
  default = null
}

variable "storage_account_id" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = null
}

variable "zones" {
  type    = list(string)
  default = null
}

variable "encryption_settings" {
  type = set(object(
    {
      disk_encryption_key = list(object(
        {
          secret_url      = string
          source_vault_id = string
        }
      ))
      enabled = bool
      key_encryption_key = list(object(
        {
          key_url         = string
          source_vault_id = string
        }
      ))
    }
  ))
  default = []
}

variable "timeouts" {
  type = set(object(
    {
      create = string
      delete = string
      read   = string
      update = string
    }
  ))
  default = []
}
