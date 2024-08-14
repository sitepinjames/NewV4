###Account level settings" 
account       = "v4-dev"
account_id    = "531277274015"
region        = "us-east-1"
vpc_id      = "vpc-0529b2ecd8cca6502"
environment   = "development"
product       = "EACMS"


#### EC2 INSTANCES BEGIN  ####
ec2_instances = {
aws-eacms-dev-01 = { 
    name           = "vmigration-instance1"
    instance_type  = "t3.micro"
    ami_id         = "ami-0ae8f15ae66fe8cda"
    # subnet_id    =   "subnet-0a65a41bb9b007e3d"
    ec2_subnet     = "10.1.1.0/24"
    aws_iam_instance_profile = " "
    key_name       = "v4migration"
    security_groups = ["first-pega-secgroup", "second-pega-secgroup"]
}
aws-eacms-drupal-02 = { 
    name           = "vmigration-instance-drupal2"
    instance_type  = "t2.micro"
    ami_id         = "ami-0583d8c7a9c35822c"
    # subnet_id    =   "subnet-0a65a41bb9b007e3d"
    ec2_subnet     = "10.1.1.0/24"
    aws_iam_instance_profile = " "
    key_name       = "v4migration"
    security_groups = ["first-pega-secgroup", "third-pega-secgroup"]
},
dev8-iacpega-02 = { 
    name           = "dev8-iacpega-02"
    instance_type  = "t2.micro"
    ami_id         = "ami-0583d8c7a9c35822c"
    # subnet_id    =   "subnet-0a65a41bb9b007e3d"
    ec2_subnet     = "10.1.3.0/24"
    aws_iam_instance_profile = " "
    key_name       = "v4migration"
    security_groups = ["first-pega-secgroup", "third-pega-secgroup"]
}
}


####################################EC2-INSTANCE END######################################################


####################################SG Rules BEGIN ########################################################################################
sec_groups = {
  "first-pega-secgroup" = {
    sg_name  = "pega1-eacms-sg"
    sg_description  ="pega1 for Dev EACMS"
    ingress_with_self = [
    {
        rule = "all-all"
 }
]
egress_with_self = [
    {
        rule = "all-all"
 }
]
ingress_with_cidr_blocks = [
    {
        from_port  =443
        to_port    =443
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.10.12.0/24"

    },
    {
      from_port  =22
        to_port    =22
        protocol   ="tcp"
        description = "NGINX From On Prem"
        cidr_block  = "0.0.0.0/0"
  
    }
]

  egress_with_cidr_blocks = [
      {
        from_port  = 0
        to_port    = 0
        protocol   = "tcp"
        cidr_block = "0.0.0.0/0"
      }
    ]
  }
  ##############################################################################3
  "second-pega-secgroup" = {
    sg_name  = "pega2-eacms-sg"
    sg_description  ="Pega2 for Dev EACMS"
    ingress_with_self = [
    {
        rule = "all-all"
 }
]
egress_with_self = [
    {
        rule = "all-all"
 }
]
ingress_with_cidr_blocks = [
    {
        from_port  =80
        to_port    =80
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.10.0.0/16"

    },
    {
      from_port  =22
        to_port    =22
        protocol   ="tcp"
        description = "PEGA From On Prem"
        cidr_block  = "0.0.0.0/0"
  
    }
]

egress_with_cidr_blocks = [
    {
        rule = "all-all"
    }
]
  }


######################################################################################################################################3333
"third-pega-secgroup" = {
    sg_name  = "drupal-eacms-sg"
    sg_description  ="drupal1 for Dev EACMS"
    ingress_with_self = [
    {
        rule = "all-all"
 }
]
egress_with_self = [
    {
        rule = "all-all"
 }
]
ingress_with_cidr_blocks = [
    {
        from_port  =8443
        to_port    =8443
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.0.0.0/16"

    },
    {
      from_port  =22
        to_port    =22
        protocol   ="tcp"
        description = "NGINX From On Prem"
        cidr_block  = "0.0.0.0/0"
  
    }
]


  egress_with_cidr_blocks = [
      {
        from_port  = 0
        to_port    = 0
        protocol   = "tcp"
        cidr_block = "0.0.0.0/0"
      }
    ]
  }
  ######################################################################################################################################3333
"elb-pega-secgroup" = {
    sg_name  = "elb-pega--eacms-sg"
    sg_description  ="drupal1 for Dev EACMS"
    ingress_with_self = [
    {
        rule = "all-all"
 }
]
egress_with_self = [
    {
        rule = "all-all"
 }
]
ingress_with_cidr_blocks = [
    {
        from_port  =8090
        to_port    =8090
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.0.0.2/32"

    },
    {
        from_port  =8080
        to_port    =8080
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.0.0.2/32"

    },
    {
        from_port  =9443
        to_port    =9443
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.0.0.2/32"

    },
    {
        from_port  =8081
        to_port    =8081
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.0.0.2/32"

    },
    {
        from_port  =8443
        to_port    =8443
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.0.0.2/32"

    },
    {
        from_port  =8091
        to_port    =8091
        protocol   ="tcp"
        description = "NGINX From AWS"
        cidr_block  = "10.0.0.2/32"

    },
    {
      from_port  =443
        to_port    =443
        protocol   ="tcp"
        description = "NGINX From On Prem"
        cidr_block  = "0.0.0.0/0"
  
    }
]


  egress_with_cidr_blocks = [
      {
        from_port  = 0
        to_port    = 0
        protocol   = "tcp"
        cidr_block = "0.0.0.0/0"
      }
    ]
  }
}
tags = { 
    product        = "AP/EACMS/DSS/HD/INFRA"
    Application    = "PA/DU/PS/WS"
    Component      = "EACMS/PEGA/DRUPAL SERVER"
    environment    = "DEV/TST/TRN/IMP/PRO"
}
 ########################################################ELB start###################################################################################
 load_balancers = {
  iac-app-01 = {
    name                      = "app-alb"
    internal                  =  true
    type                      = "application"
    security_groups           = ["elb-pega-secgroup","third-pega-secgroup"]
    subnet_ids                = ["subnet-0a65a41bb9b007e3d","subnet-04debc31dda1b97ee","subnet-08d8df01cf9d2e724"]
 } ,
 alb-02 = {
    name                      = "api-alb"
    internal                  = true
    type                      = "application"
    security_groups           = ["second-pega-secgroup"]
    subnet_ids                = ["subnet-0a65a41bb9b007e3d","subnet-08d8df01cf9d2e724"]
  }
}
listeners = [
  {
    load_balancer_key = "iac-app-01"
    port              = 8082
    protocol          = "HTTP"
    default_action = {
      type              = "forward"
      target_group_name = "iac-pa-8081"
    }
  },
  {
    load_balancer_key = "iac-app-01"
    port              = 8443
    protocol          = "HTTP"
    default_action = {
      type              = "forward"
      target_group_name = "iac-du-9443"
    }
  },
    {
    load_balancer_key = "iac-app-01"
    port              = 800
    protocol          = "HTTP"
    default_action = {
      type              = "forward"
      target_group_name = "iac-pa-8081"
    }
  },
  {
    load_balancer_key = "alb-02"
    port              = 8805
    protocol          = "HTTP"
    default_action = {
      type              = "forward"
      target_group_name = "iac-ps-8080"
    }
  },
  {
    load_balancer_key = "alb-02"
    port              = 8080
    protocol          = "HTTP"
    default_action = {
      type              = "forward"
      target_group_name = "iac-ps-8080"
    }
  },
   {
    load_balancer_key = "alb-02"
    port              = 8093
    protocol          = "HTTP"
    default_action = {
      type              = "forward"
      target_group_name = "iac-ps-8080"
    }
  },
]

# listeners = {
#     "iac-app-01-https" = {
#       load_balancer_key = "iac-app-01"
#       port = 8443
#       protocol = "HTTPS"
#       default_action = {
#         type = "forward"
#         target_group_name = "iac-ps-8080"
#       }
#     },
#     "iac-app-01-http" =    { 
#       load_balancer_key = "iac-app-01"
#       port = 8091
#       protocol = "HTTP"
#       default_action = {
#         type = "forward"
#         target_group_name = "iac-pa-8081"
#       }
#     },
#     "iac-app-01-http" = { 
#       load_balancer_key = "iac-app-01"
#       port = 8080
#       protocol = "HTTP"
#       default_action = {
#         type = "forward"
#         target_group_name = "iac-du-9443"
#       }
#     },
#     "iac-app-01-http" = { 
#       load_balancer_key = "iac-app-01"
#       port = 8081
#       protocol = "HTTP"
#       default_action = {
#         type = "forward"
#         target_group_name = "iac-ps-8080"
#       }
#     },
#     "iac-app-01-http" = { 
#       load_balancer_key = "iac-app-01"
#       port = 443
#       protocol = "HTTP"
#       default_action = {
#         type = "forward"
#         target_group_name = "iac-pa-8081"
#       }
#     },
#     "iac-app-01-http" ={ 
#       load_balancer_key = "iac-app-01"
#       port = 8090
#       protocol = "HTTP"
#       default_action = {
#         type = "forward"
#         target_group_name = "iac-du-9443"
#       }
#     }
    
# # }   
#   alb-02 = {
#     name                      = "api-alb"
#     internal                  = true
#     type                      = "application"
#     security_groups           = ["second-pega-secgroup"]
#     subnet_ids                = ["subnet-0a65a41bb9b007e3d","subnet-04debc31dda1b97ee"]
#     listener = {
#       port = 80
#       protocol = "HTTP"
#       default_action = {
#         type = "forward"
#         target_group_name = "tg-api"
#       }
#     }
#   }
#   }
# }


#### Target Groups ####
target_groups = {
  iac-ps-8080 = {
    name     = "iac-ps-8080"
    port     = 8080
    protocol = "HTTP"
    target_type = "instance"
    # instances = ["i-0dc92c8123e6a74f5", "i-03da5d126c0bab231"] # List your instance IDs here
    health_check = {
      interval           = 30
      path               = "/health"
      timeout            = 5
      healthy_threshold  = 5
      unhealthy_threshold = 2
      protocol           = "HTTP"
    }
    stickiness = {
      enabled         = true
      type            = "lb_cookie"
      cookie_duration = 3600  # 1 hour
    }
  },
  iac-du-9443 = {
    name     = "iac-du-9443"
    port     = 443
    protocol = "HTTPS"
    # instances = ["i-00cad8f5846f10275"] # List your instance IDs here
    health_check = {
      interval           = 30
      path               = "/"
      timeout            = 5
      healthy_threshold  = 5
      unhealthy_threshold = 2
      protocol           = "HTTPS"
    }
    matcher = "200"
    stickiness = {
      enabled         = true
      type            = "lb_cookie"
      cookie_duration = 86400  # 1 day
    }
  },
  iac-pa-8081 = {
    name     = "iac-pa-8081"
    port     = 8080
    protocol = "HTTPS"
    health_check = {
      interval           = 30
      path               = "/health"
      timeout            = 5
      healthy_threshold  = 5
      unhealthy_threshold = 2
      protocol           = "HTTPS"
    }
    matcher = "200"
    stickiness = {
      enabled         = true
      type            = "lb_cookie"
      cookie_duration = 86400  # 1 day
    }
  }
}
instance_attachments = {
  "attachment_1" = {
    target_group_name = "iac-pa-8081"
    instance_id       = "i-00cad8f5846f10275" # Example instance ID
  },
  "attachment_2" = {
    target_group_name = "iac-ps-8080"
    instance_id       = "i-0dc92c8123e6a74f5" # Example instance ID
  },
  "attachment_3" = {
    target_group_name = "iac-du-9443"
    instance_id       = "i-0dc92c8123e6a74f5"  # Example instance ID
  }
  # Add more attachments as needed
}





