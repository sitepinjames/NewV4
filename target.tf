resource "aws_lb_target_group" "app_target_group" {
  for_each = var.target_groups

  name     = each.value["name"]
  port     = each.value["port"]
  protocol = each.value["protocol"]
  vpc_id   = var.vpc_id

  health_check {
    interval            = lookup(each.value["health_check"], "interval", 30)
    path                = lookup(each.value["health_check"], "path", "/")
    timeout             = lookup(each.value["health_check"], "timeout", 5)
    healthy_threshold   = lookup(each.value["health_check"], "healthy_threshold", 5)
    unhealthy_threshold = lookup(each.value["health_check"], "unhealthy_threshold", 2)
    protocol            = lookup(each.value["health_check"], "protocol", "HTTP")
  }

  target_type = lookup(each.value, "target_type", "instance")

  # Stickiness settings
  stickiness {
    enabled         = lookup(each.value["stickiness"], "enabled", false)
    type            = lookup(each.value["stickiness"], "type", "lb_cookie")
    cookie_duration = lookup(each.value["stickiness"], "cookie_duration", 86400) # default 1 day
  }

}

resource "aws_lb_target_group_attachment" "app_tg_attachment" {
  for_each = var.target_group_attachments

  target_group_arn = aws_lb_target_group.app_target_group[each.value.target_group_name].arn
  target_id        = each.value["instance_id"]
  port             = aws_lb_target_group.app_target_group[each.value.target_group_name].port
}
# resource "aws_lb_target_group_attachment" "app_tg_attachment" {
#   for_each = var.ec2_instances

#   target_group_arn = aws_lb_target_group.app_target_group[lookup(each.value, "target_group_name", "")].arn
#   target_id        = aws_instance.dev_ec2-secgroup[each.key].id
#   port             = lookup(each.value, "target_port", 80)
# }
