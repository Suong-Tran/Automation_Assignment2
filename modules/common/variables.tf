variable "location" {
  default = ""
}

variable "rg" {
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
