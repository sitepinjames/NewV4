resource "aws_instance" "dev_ec2-instance"{
    
    for_each = var.ec2_instances

    
    # ami = data.aws_ami.bsb_ami[each.key].image_id
   
    instance_type = each.value["instance_type"]
    ami = each.value["ami_id"]
    # private_ip = each.value["static_ip"] ? each.value["private_ip"] : null
    # subnet_id = each.value["subnet_id"]
    subnet_id = data.aws_subnet.ec2_instance[each.key].id

    key_name  =  each.value["key_name"]

    vpc_security_group_ids = [
    for sg_name in each.value["security_groups"] : aws_security_group.dev_devsecgroup[sg_name].id
  ]

   
  tags = merge(
    var.tags,                # Common tags from variable
    {
      Name = each.value["name"]  # Unique tag for the EC2 instance
    }
  )
}
