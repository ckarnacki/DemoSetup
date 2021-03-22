terraform {
  required_providers {
    pagerduty = {
      source = "PagerDuty/pagerduty"
      # version = "~> 3.27"
    }
  }
  backend "remote" {
    organization = "pd_sc_west"

    workspaces {
      name = "template"
    }
  }
}

provider "pagerduty" {
  token = var.pagerduty_token
}


# Use a module to create USERS
module "add_users" {
  # TODO: look into if we can get away without using absolute path below
  source = "/Users/pkennard/Documents/terraform/shared_instance/modules/users/"
# Edit names below or leave commented out for defaults
  c_lvl_email = "c_lvl_email@email${var.demoer_ns}.com"
  dr_lvl_email = "dr_lvl_email@email${var.demoer_ns}.com"
  mgr_lvl_email = "mgr_lvl_email@email${var.demoer_ns}.com"
  resp_lvl_1_email = "resp_lvl_1_email@email${var.demoer_ns}.com"
  resp_lvl_2_email = "resp_lvl_2_email@email${var.demoer_ns}.com"
}
# add USERS without module
/*
resource "pagerduty_user" "NAME_YOUR_RESOURCE" {
  name  = "NAME IN PD"
  email = "EMAIL@EMAIL${var.demoer_ns}.COM"
  role  = "OPTIONAL"
}
*/

# Use a module to create SCHEDULES

# Use a module to create ESCALATION POLICIES
