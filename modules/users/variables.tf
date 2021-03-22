variable "c_lvl_name" {
  description = "This is a C level stakeholder, they are in Executive Team"
  default = "CXO User"
}
variable "c_lvl_email" {
  type = string
}

variable "dr_lvl_name" {
  description = "This is a Director level responder/stakeholder"
  default = "Dr Pepper"
}
variable "dr_lvl_email" {
  type = string
}

variable "mgr_lvl_name" {
  description = "This is a Manager level responder/stkhldr, EP backstop"
  default = "Gal Ager"
}
variable "mgr_lvl_email" {
  type = string
}

variable "resp_lvl_1_name" {
  description = "This is the first responder"
  default = "Jane Doe"
}
variable "resp_lvl_1_email" {
  type = string
}

variable "resp_lvl_2_name" {
  description = "This is the second responder"
  default = "John Doe"
}
variable "resp_lvl_2_email" {
  type = string
}
