# MAIN VARIABLES

variable "environment" {
  description = "The environment for which this configuration is applied."
  type        = string
}
variable "vpc_id" {
    type = string
    description = "VPC-for-dev4"
}

variable "subnet_id" {
  description = "The subnet ID for the instance."
  type        = list(string)
}

# variable "vpc_security_group_ids" {
#   description = "The security group IDs for the instance."
#   type        = list(string)
# }

variable "availability_zone" {
  description = "Availabilty zone for ebs volume."
  type        = list(string)
}

variable "key_name" {
  description = "The key pair name for SSH access."
  type        = string
}

# variable "permissions_boundary" {
#   description = "Permissions boundary"
#   type        = string
# }

variable "iam_instance_profile" {
  description = "The IAM instance profile name for SSM."
  type        = string
}


########## DRUPAL ###########

variable "drupal_ami" {
  description = "The AMI ID for the Drupal instance."
  type        = string
}

variable "number_of_drupal_instances" {
  description = "Number of Drupal servers."
  type        = number
}

variable "drupal_volume_size" {
  description = "The size of the root volume in GB."
  type        = number
}

variable "drupal_instance_type" {
  description = "Instance type for drupal server."
  type        = list(string)
}

variable "drupal_security_group_ids" {
  description = "Security groups for Drupal server."
  type        = list(string)
}


########## PEGA ###########

variable "pega_ami" {
  description = "The AMI ID for the PEGA instance."
  type        = string
}

variable "number_of_pega_instances" {
  description = "Number of PEGA servers."
  type        = number
}

variable "pega_volume_size" {
  description = "The size of the root volume in GB."
  type        = number
}

variable "pega_instance_type" {
  description = "Instance type for pega server."
  type        = list(string)
}

variable "pega_security_group_ids" {
  description = "Security groups for PEGA server."
  type        = list(string)
}


########## NGINX ###########

variable "nginx_ami" {
  description = "The AMI ID for the NGINX instance."
  type        = string
}

variable "number_of_nginx_instances" {
  description = "Number of NGINX servesr."
  type        = number
}

variable "nginx_volume_size" {
  description = "The size of the root volume in GB."
  type        = number
}

variable "nginx_instance_type" {
  description = "Instance type for NGINX server."
  type        = list(string)
}

variable "nginx_security_group_ids" {
  description = "Security groups for NGINX server."
  type        = list(string)
}
################################# PEGA/DRUPAL LAYER -LOAD_BALANCER #################################################3
variable "PegaDrupal_load_balancer" {
  description = "Configuration for the application load balancer"
  type = object({
    name                        = string
    internal                    = bool
    load_balancer_type          = string
    security_groups             = list(string)
    subnet_ids                  = list(string)
    enable_deletion_protection  = bool
  })
}

variable "PegaDrupal_listeners" {
  description = "Map of listeners for the load balancer"
  type = map(object({
    port              = number
    protocol          = string
    default_action = object({
      type             = string
      target_group_name = string
    })
  }))
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
variable "target_group_attachments" {
  description = "Map of target group attachments"
  type = map(object({
    target_group_name = string
    instance_id       = string
  }))
}
# variable "PegaDrupal_listeners" {
#   type = list(object({
#     load_balancer_key = string
#     port              = number
#     protocol          = string
#     default_action    = object({
#       type              = string
#       #target_group_name = string
#     })
#   }))
# }
###################################### NGINX LAYER -LOAD_BALANCER ##########################################################################
# variable "Nginx_load_balancer" {
#   description = "Configuration for the application load balancer"
#   type = object({
#     name                        = string
#     internal                    = bool
#     load_balancer_type          = string
#     security_groups             = list(string)
#     subnet_ids                  = list(string)
#     enable_deletion_protection  = bool
#     tags                        = map(string)
#   })
# }


# variable "Nginx_listeners" {
#   description = "Map of listeners for the load balancer"
#   type = map(object({
#     port              = number
#     protocol          = string
#     default_action = object({
#       type             = string
#       target_group_name = string
#     })
#   }))
# }