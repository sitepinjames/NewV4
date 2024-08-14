######  DRUPAL ######

resource "aws_instance" "Drupal" {
  ami           = var.drupal_ami
  instance_type = element(var.drupal_instance_type, count.index)
  availability_zone = element(var.availability_zone, count.index)
  key_name      = var.key_name 
  # disable_api_termination = true
  # disable_api_stop = true
  metadata_options{
    instance_metadata_tags = "enabled"
  }
  count = var.number_of_drupal_instances

  tags = {
    Name = "${format("%s8-drupal-dl-ds-%02s",var.environment,count.index+1)}",
    Role = "${format("%s_drupal_server",var.environment)}"
  }

  root_block_device {
    volume_size = var.drupal_volume_size
    volume_type = "gp3"
  }
  iam_instance_profile = var.iam_instance_profile

  subnet_id               = element(var.subnet_id, count.index)
  vpc_security_group_ids  = var.drupal_security_group_ids

  lifecycle {
    create_before_destroy = true
  }
  user_data = <<-EOF
  #!/bin/sh
  EOF
}

######  PEGA ######

resource "aws_instance" "Pega" {
  ami           = var.pega_ami
  instance_type = element(var.pega_instance_type, count.index)
  availability_zone = element(var.availability_zone, count.index)
  key_name      = var.key_name 
  # disable_api_termination = true
  # disable_api_stop = true
  metadata_options{
    instance_metadata_tags = "enabled"
  }
  count = var.number_of_pega_instances

  tags = {
    Name = "${format("%s8-pega-dl-ds-%02s",var.environment,count.index+1)}",
    Role = "${format("%s_pega_server",var.environment)}"
  }

  root_block_device {
    volume_size = var.pega_volume_size
    volume_type = "gp3"
  }
  iam_instance_profile = var.iam_instance_profile

  subnet_id               = element(var.subnet_id, count.index)
  vpc_security_group_ids  = var.pega_security_group_ids

  lifecycle {
    create_before_destroy = true
  }
  user_data = <<-EOF
  #!/bin/sh
  EOF
}

######  NGINX ######

resource "aws_instance" "nginx" {
  ami           = var.nginx_ami
  instance_type = element(var.nginx_instance_type, count.index)
  availability_zone = element(var.availability_zone, count.index)
  key_name      = var.key_name 
  # disable_api_termination = true
  # disable_api_stop = true
  metadata_options{
    instance_metadata_tags = "enabled"
  }
  count = var.number_of_nginx_instances

  tags = {
    Name = "${format("%s8-nginx-dl-ds-%02s",var.environment,count.index+1)}",
    Role = "${format("%s_nginx_server",var.environment)}"
  }

  root_block_device {
    volume_size = var.nginx_volume_size
    volume_type = "gp3"
  }
  iam_instance_profile = var.iam_instance_profile

  subnet_id               = element(var.subnet_id, count.index)
  vpc_security_group_ids  = var.nginx_security_group_ids

  lifecycle {
    create_before_destroy = true
  }
  user_data = <<-EOF
  #!/bin/sh
  EOF
}