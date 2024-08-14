# MAIN VARIABLES

variable "environment" {
  description = "The environment for which this configuration is applied."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID for the instance."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "The security group IDs for the instance."
  type        = list(string)
}

variable "availability_zone" {
  description = "Availabilty zone for ebs volume."
  type        = list(string)
}

variable "key_name" {
  description = "The key pair name for SSH access."
  type        = string
}

variable "permissions_boundary" {
  description = "Permissions boundary"
  type        = string
}

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
