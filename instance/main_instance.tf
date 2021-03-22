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
      name = "shared_demo_instance"
    }
  }
}

provider "pagerduty" {
  token = var.pagerduty_token
}

#Create default shared USERS
resource "pagerduty_user" "stkhldr" {
  name  = "Black Angus"
  email = "ba@email.com"
  role  = "observer"
}
resource "pagerduty_user" "exec" {
  name  = "Exe Cutive"
  email = "ec@email.com"
  role  = "observer"
}
resource "pagerduty_user" "cstsvc" {
  name  = "Cust Omer"
  email = "co@email.com"
  role  = "observer"
}
# Create default shared TEAMS
resource "pagerduty_team" "stkhldrs" {
  name        = "Stakeholders"
  description = "All stakeholders"
}
resource "pagerduty_team" "execs" {
  name        = "Executives"
  description = "All executives"
}
resource "pagerduty_team" "cstsvcs" {
  name        = "Customer Service"
  description = "Customer Service stakeholders"
}

# Add default shared USERS to default shared TEAMS
resource "pagerduty_team_membership" "stakeholders" {
  user_id = pagerduty_user.stkhldr.id
  team_id = pagerduty_team.stkhldrs.id
  #role    = "manager"
}
resource "pagerduty_team_membership" "executives" {
  user_id = pagerduty_user.exec.id
  team_id = pagerduty_team.execs.id
  #role    = "manager"
}
resource "pagerduty_team_membership" "customer_service" {
  user_id = pagerduty_user.cstsvc.id
  team_id = pagerduty_team.cstsvcs.id
  #role    = "manager"
}

# Add default shares ESCALATION POLICIES
# Imported this one and then had to fill out/clean it up from states
resource "pagerduty_escalation_policy" "customer_ops_ep" {
  name      = "Customer Ops EP"
  num_loops = 1
  rule {
    escalation_delay_in_minutes = 15
    #"id": "PEJGBRN",
    target {
      type = "schedule_reference"
      id   = "P4136PV"
    }
  }
  rule {
    escalation_delay_in_minutes = 30
    #"id": "PBNVABK",
    target {
      id   = "PK7OVRU"
      type = "schedule_reference"
    }
  }
  # (resource arguments)
}

# Add default shared RESPONSE PLAYS
resource "pagerduty_response_play" "brb" {
  name        = "Big Red Button"
  from        = pagerduty_user.pk.email
  description = ""

  # Docs say a responder block is required... might want to test
  # Turns out a responder block is required...
  responder {
    type = "escalation_policy_reference"
    id   = pagerduty_escalation_policy.customer_ops_ep.id
  }
  subscriber {
    type = "team_reference"
    id   = pagerduty_team.stkhldrs.id
  }
  runnability = "services"
}

# Add default shared BUSINESS SERVICES
resource "pagerduty_business_service" "bs1" {
  name        = "Our most important Service"
  description = "A very descriptive description of this business service"
  #point_of_contact = "PagerDuty Admin"
  #team             = "P37RSRS"
}

# Add default shared TECHNICAL SERVICES
resource "pagerduty_service" "ts1" {
  name = "My Web App"
  #auto_resolve_timeout    = 14400
  #acknowledgement_timeout = 600
  escalation_policy = pagerduty_escalation_policy.customer_ops_ep.id
  alert_creation    = "create_alerts_and_incidents"
  alert_grouping    = "intelligent"
  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}

# Add default shared SERVICE DEPENDENCIES
resource "pagerduty_service_dependency" "sd1" {
  dependency {
    dependent_service {
      id   = pagerduty_business_service.bs1.id
      type = "business_service"
    }
    supporting_service {
      id   = pagerduty_service.ts1.id
      type = "service"
    }
  }
}

# Add ADDON for TF Cloud Dashboard
/*
resource "pagerduty_addon" "tfwsp" {
  name = "Terraform Workspace Page"
  src  = "https://app.terraform.io/app/pd_sc_west/workspaces"
}
*/

# Create PagerDuty DEMOERs (Users)
/*
resource "pagerduty_user" "ck" {
  name  = "Chris Karnacki"
  email = "ck@email.com"
  role  = "admin"
}
resource "pagerduty_user" "cg" {
  name  = "Casey Goebel"
  email = "cg@email.com"
  role  = "admin"
}
resource "pagerduty_user" "lc" {
  name  = "Laura Chassagne"
  email = "lc@email.com"
  role  = "admin"
}
*/
resource "pagerduty_user" "pk" {
  name  = "Patrick Kennard"
  email = "pk@email.com"
  role  = "admin"
}
resource "pagerduty_user" "sm" {
  name  = "Sanjay Mallik"
  email = "sm@email.com"
  role  = "admin"
}
