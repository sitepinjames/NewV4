# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "9.10.0"
# }

#   name    = local.name
#   vpc_id  = module.vpc.vpc_id
#   subnets = module.vpc.public_subnets
#   enable_deletion_protection = false
#   security_group = 
  
#   connection_logs = {
#     bucket  = module.log_bucket.s3_bucket_id
#     enabled = true
#     prefix  = "connection-logs"
#   }
    
#   access_logs = {
#     bucket = module.log_bucket.s3_bucket_id
#     prefix = "access-logs"
#   }

#   client_keep_alive = 7200
    
  
    
  
