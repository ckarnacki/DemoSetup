## ToDo:
#### Add job_title to these users
terraform {
  required_providers {
    pagerduty = {
      source = "PagerDuty/pagerduty"
      # version = "~> 3.27"
    }
  }
}
resource "pagerduty_user" "clevel" {
  name  = var.c_lvl_name
  email = var.c_lvl_email
  #teams = [pagerduty_team.engineering.id]
}
resource "pagerduty_user" "dr_lvl" {
  name  = var.dr_lvl_name
  email = var.dr_lvl_email
  #teams = [pagerduty_team.engineering.id]
}
resource "pagerduty_user" "mgr_lvl" {
  name  = var.mgr_lvl_name
  email = var.mgr_lvl_email
  #teams = [pagerduty_team.engineering.id]
}
resource "pagerduty_user" "resp_lvl_1" {
  name  = var.resp_lvl_1_name
  email = var.resp_lvl_1_email
  #teams = [pagerduty_team.engineering.id]
}
resource "pagerduty_user" "resp_lvl_2" {
  name  = var.resp_lvl_2_name
  email = var.resp_lvl_2_email
  #teams = [pagerduty_team.engineering.id]
}
