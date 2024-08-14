variable "region" {
    type = string
    description = "AWS Region"
}

variable "account_id" {
    type = string
    description = "Target AWS account id"
}

variable "account" {
    type = string
    description = "Target account name"
}

variable "vpc_id" {
    type = string
    description = "VPC-for-dev4"
}
# # variable "vpc_name" {
# #     type = string
# #     description = "VPC-for-dev4"
# }
# # variable "sys_name" {
# #     type = string
# #     description = "System Name"
# }

variable "ec2_instances" {
    type = map(any)
    description = "Configuration information for EC2 instances that make up the System"
}

variable "sec_groups" {
    type = map(any)
    description = "Security Groups to be used by application instances"
}

variable "tags" {
    type = map(any)
    description = "Optional map of tags to set on resources, defaults to empty map"
}
variable "environment" {
    type = string
    description = "Optional map of tags to set on resources, defaults to empty map"
}
variable "load_balancers" {
  type = map(object({
    name                      = string
    internal                  = bool
    type                      = string
    security_groups           = list(string)
    subnet_ids                = list(string)
    enable_deletion_protection = optional(bool)
  }))
  description = "Configuration for Application Load Balancers"
}
variable "listeners" {
  type = list(object({
    load_balancer_key = string
    port              = number
    protocol          = string
    default_action    = object({
      type              = string
      target_group_name = string
    })
  }))
  description = "List of listeners for each load balancer"
}


variable "target_groups" {
  type = map(object({
    name                = string
    port                = number
    protocol            = string
    health_check        = object({
    interval           = optional(number)
    path               = optional(string)
    timeout            = optional(number)
    healthy_threshold  = optional(number)
    unhealthy_threshold = optional(number)
    protocol           = optional(string)
    })
    stickiness = object({
      enabled         = bool
      type            = string
      cookie_duration = number
    })
  }))
  description = "Configuration for Target Groups"
}

variable "instance_attachments" {
  type = map(object({
    target_group_name = string
    instance_id       = string
  }))
  description = "Map of instances to be attached to target groups"
}
