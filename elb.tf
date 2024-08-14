resource "aws_lb" "app_load_balancer" {
  for_each = var.load_balancers

  name               = each.value["name"]
  internal           = each.value["internal"]
  load_balancer_type = each.value["type"]
  security_groups    = [for sg_name in each.value["security_groups"] : aws_security_group.dev_devsecgroup[sg_name].id]
  # subnets            = data.aws_subnet.alb[each.key].id
  subnets            = each.value["subnet_ids"]
  
  enable_deletion_protection = lookup(each.value, "enable_deletion_protection", false)

  tags = merge(
    var.tags,
    {
      Name = each.value["name"]
    }
  )
}

resource "aws_lb_listener" "app_listener" {
  count = length(var.listeners)

  load_balancer_arn = aws_lb.app_load_balancer[var.listeners[count.index].load_balancer_key].arn
  port              = var.listeners[count.index].port
  protocol          = var.listeners[count.index].protocol

  default_action {
    type             = var.listeners[count.index].default_action.type
    target_group_arn = aws_lb_target_group.app_target_group[var.listeners[count.index].default_action.target_group_name].arn
  }
}
