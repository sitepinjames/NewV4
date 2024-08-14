resource "aws_security_group" "dev_devsecgroup"{
   
    for_each = var.sec_groups

    name = each.value["sg_name"]
    description = each.value["sg_description"]
    vpc_id = var.vpc_id
    dynamic "ingress" {
        for_each = lookup(each.value, "ingress_with_cidr_blocks", [])
        content {
            from_port   = lookup(ingress.value, "from_port", 0)
            to_port     = lookup(ingress.value, "to_port", 0)
            protocol    = lookup(ingress.value, "protocol", "tcp")
            cidr_blocks = [lookup(ingress.value, "cidr_block", "0.0.0.0/0")]
    }
  }

  dynamic "egress" {
        for_each = lookup(each.value, "egress_with_cidr_blocks", [])
        content {
            from_port   = lookup(egress.value, "from_port", 0)
            to_port     = lookup(egress.value, "to_port", 0)
            protocol    = lookup(egress.value, "protocol", "tcp")
            
    }
  }

    tags = merge(
    var.tags,                # Common tags from variable
    {
      Name = each.value["sg_name"]  # Unique tag for the EC2 instance
    }
  )
}
