# Data Function Calls

# Network Data
data "aws_vpc" "Dev-v4" {
    
         id= var.vpc_id
}

data "aws_subnet" "ec2_instance" {
    for_each = var.ec2_instances

    # id = each.value["subnet_id"]
    cidr_block = each.value["ec2_subnet"]
}
# data "aws_subnet" "alb" {
#     for_each = var.load_balancers

#     id = tolist(each.value["subnet_ids"])
# }
# data "aws_security_group" "pega-secgrp" {
#     filter {
#         name = "tag:Name"
#         values = ["${data.aws_vpc.Dev-v4.tags["Name"]}-Pega_sg"]
#     }
# }

# data "aws_security_group" "Drupal-secgrp" {
#     filter {
#         name = "tag:Name"
#         values = ["${data.aws_vpc.Dev-v4.tags["Name"]}-Drupal_sg"]
#     }
# }


# data "aws_ami" "bsb_ami" {
#     for_each = var.ec2_instances

#     id= each.value["ami_id"]
# }