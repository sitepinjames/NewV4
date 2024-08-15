###Account level settings" 
account       = "v4-dev"
account_id    = "531277274015"
region        = "us-east-1"
vpc_id      = "vpc-0529b2ecd8cca6502"
# environment   = "development"
# product       = "EACMS"


# MAIN TFVARS
environment             = "dev"
availability_zone       = ["us-east-1a", "us-east-1b"]
key_name                = "v4migration"
iam_instance_profile    = "EC2toSSM"
subnet_id               = ["subnet-0a65a41bb9b007e3d", "subnet-04debc31dda1b97ee" ]
#permissions_boundary = "arn:aws:iam::919833248227:policy/cms-cloud-admin/ct-ado-poweruser-permissions-boundary-policy"
 
 
# DRUPAL TFVARS
drupal_ami                = "ami-0583d8c7a9c35822c"
drupal_instance_type           = ["t2.medium", "t2.medium"]
drupal_volume_size             = 50
#vpc_security_group_ids  = ["sg-07a01c0afc77fe4df", "sg-0850b6215ba649b81"] # Waiting on Roop also change name
number_of_drupal_instances    = 1
drupal_security_group_ids = ["sg-07a01c0afc77fe4df", "sg-0850b6215ba649b81"]
 
 
# PEGA TFVARS
pega_ami                = "ami-0583d8c7a9c35822c"
pega_instance_type           = ["r4.xlarge", "r4.xlarge"]
pega_volume_size             = 50
# nginx_security_group_ids  = [""] # Waiting on Roop also change name
number_of_pega_instances    = 2
pega_security_group_ids = ["sg-07a01c0afc77fe4df", "sg-0bb19e031ed739da8"]
 
 
# NGINX
nginx_ami                = "ami-0583d8c7a9c35822c"
nginx_instance_type           = ["t2.medium", "t2.medium"]
nginx_volume_size             = 50
# vpc_security_group_ids  = [""] # Waiting on Roop also change name
number_of_nginx_instances    = 1
nginx_security_group_ids = ["sg-0df674633d1b1c3db"]

############################################ PEGADRUPAL-LOAD-BALANCER ########################################################
PegaDrupal_load_balancer = {
    name                        = "Pega-Drupal-Load-Blancer"
    internal                    = true
    load_balancer_type          = "application"
    security_groups             = ["sg-0df674633d1b1c3db"]
    subnet_ids                  = ["subnet-08d8df01cf9d2e724", "subnet-0a65a41bb9b007e3d","subnet-04debc31dda1b97ee"]
    enable_deletion_protection  = true
    }
PegaDrupal_listeners = {
  "http_listener_80" = {
    port              = 80
    protocol          = "HTTP"
    default_action = {
    type             = "forward"
    target_group_name = "myiac-pa-8081"
    }
  },
  "https_listener_443" = {
    port              = 8092
    protocol          = "HTTP"
    default_action = {
    type             = "forward"
    target_group_name = "myiac-du-9443"
    }
  },
  "http_listener_8080" = {
    port              = 8080
    protocol          = "HTTP"
    default_action = {
    type             = "forward"
    target_group_name = "myiac-ps-8080"
    }
  }
}
#### Target Groups ####
target_groups = {
  myiac-ps-8080 = {
    name     = "myiac-ps-8080"
    port     = 81
    protocol = "HTTP"
    target_type = "instance"
    # instances = ["i-048367ee92a2f7868", "i-08a54cccdf0c4438c"] # List your instance IDs here
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
  myiac-du-9443 = {
    name     = "myiac-du-9443"
    port     = 8819
    protocol = "HTTP"
    # instances = ["i-00cad8f5846f10275"] # List your instance IDs here
    health_check = {
      interval           = 30
      path               = "/"
      timeout            = 5
      healthy_threshold  = 5
      unhealthy_threshold = 2
      protocol           = "HTTP"
    }
    matcher = "200"
    stickiness = {
      enabled         = true
      type            = "lb_cookie"
      cookie_duration = 86400  # 1 day
    }
  },
  myiac-pa-8081 = {
    name     = "myiac-pa-8081"
    port     = 8080
    protocol = "HTTP"
    health_check = {
      interval           = 30
      path               = "/health"
      timeout            = 5
      healthy_threshold  = 5
      unhealthy_threshold = 2
      protocol           = "HTTP"
    }
    matcher = "200"
    stickiness = {
      enabled         = true
      type            = "lb_cookie"
      cookie_duration = 86400  # 1 day
    }
  }
}
target_group_attachments = {
  "attachment_1" = {
    target_group_name = "myiac-pa-8081"
    instance_id       = "i-063b501ba53f2cee4" # Example instance ID
  },
  "attachment_2" = {
    target_group_name = "myiac-ps-8080"
    instance_id       = "i-048367ee92a2f7868" # Example instance ID
  },
  "attachment_3" = {
    target_group_name = "myiac-du-9443"
    instance_id       = "i-08a54cccdf0c4438c"  # Example instance ID
  }
  # Add more attachments as needed
}






########################################### PEGADRUPAL-LOAD-BALANCER ########################################################