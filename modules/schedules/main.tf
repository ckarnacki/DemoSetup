### THIS IS THE EXAMPLE FROM THE DOCS
resource "pagerduty_user" "example" {
  name  = "Earline Greenholt"
  email = "125.greenholt.earline@graham.name"
  teams = [pagerduty_team.example.id]
}

resource "pagerduty_schedule" "foo" {
  name      = "Daily Engineering Rotation"
  time_zone = "America/New_York"

  layer {
    name                         = "Night Shift"
    start                        = "2015-11-06T20:00:00-05:00"
    rotation_virtual_start       = "2015-11-06T20:00:00-05:00"
    rotation_turn_length_seconds = 86400
    users                        = [pagerduty_user.foo.id]

    restriction {
      type              = "daily_restriction"
      start_time_of_day = "08:00:00"
      duration_seconds  = 32400
    }
  }
}
