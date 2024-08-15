###################################### PEGA AND DURPAL TRAFFIC ##############################################################
resource "aws_lb" "PegaDrupal_load_balancer" {
  name               = var.PegaDrupal_load_balancer.name
  internal           = var.PegaDrupal_load_balancer.internal
  load_balancer_type = var.PegaDrupal_load_balancer.load_balancer_type
  security_groups    = var.PegaDrupal_load_balancer.security_groups
  subnets            = var.PegaDrupal_load_balancer.subnet_ids

  enable_deletion_protection = var.PegaDrupal_load_balancer.enable_deletion_protection
}


# resource "aws_lb_listener" "PegaDrupal_PegaDrupal_listeners" {
#   count = length(var.PegaDrupal_listeners)

#   load_balancer_arn = aws_lb.PegaDrupal_load_balancer[var.PegaDrupal_listeners[count.index].load_balancer_key].arn
#   port              = var.PegaDrupal_listeners[count.index].port
#   protocol          = var.PegaDrupal_listeners[count.index].protocol

#   default_action {
#     type             = var.PegaDrupal_listeners[count.index].default_action.type
#     #target_group_arn = aws_lb_target_group.app_target_group[var.PegaDrupal_listeners[count.index].default_action.target_group_name].arn
#   }
# }

resource "aws_lb_listener" "PegaDrupal_PegaDrupal_listenersr" {
  for_each = var.PegaDrupal_listeners

  load_balancer_arn = aws_lb.PegaDrupal_load_balancer.arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type             = each.value.default_action.type
    target_group_arn = aws_lb_target_group.app_target_group[each.value.default_action.target_group_name].arn
  }
}
###################################### NGINX TRAFFIC ##############################################################
# resource "aws_lb" "PegaDrupal_load_balancer" {
#   name               = var.PegaDrupal_load_balancer.name
#   internal           = var.PegaDrupal_load_balancer.internal
#   load_balancer_type = var.PegaDrupal_load_balancer.load_balancer_type
#   security_groups    = var.PegaDrupal_load_balancer.security_groups
#   subnets            = var.PegaDrupal_load_balancer.subnet_ids

#   enable_deletion_protection = var.PegaDrupal_load_balancer.enable_deletion_protection
# }

# resource "aws_lb_listener" "PegaDrupal_PegaDrupal_listenersr" {
#   count = length(var.PegaDrupal_listeners)

#   load_balancer_arn = aws_lb.PegaDrupal_load_balancer[var.PegaDrupal_listeners[count.index].load_balancer_key].arn
#   port              = var.PegaDrupal_listeners[count.index].port
#   protocol          = var.PegaDrupal_listeners[count.index].protocol

#   default_action {
#     type             = var.PegaDrupal_listeners[count.index].default_action.type
#     target_group_arn = aws_lb_target_group.app_target_group[var.PegaDrupal_listeners[count.index].default_action.target_group_name].arn
#   }
# }




# resource "aws_lb_listener" "PegaDrupal_PegaDrupal_listenersr" {
#   for_each = var.PegaDrupal_listeners

#   load_balancer_arn = aws_lb.PegaDrupal_load_balancer.arn
#   port              = each.value.port
#   protocol          = each.value.protocol

#   default_action {
#     type             = each.value.default_action.type
#     target_group_arn = aws_lb_target_group.app_target_group[each.value.default_action.target_group_name].arn
#   }
# }