# Retrieve environment data from AWS

data "aws_caller_identity" "current" {}
data "aws_vpc" "vpc" {}

data "aws_subnets" "private" {
  tags = {
    use = "private"
  }
}

data "aws_security_group" "cmscloud-security-tools" {
  tags = {
    Name      = "cmscloud-security-tools"
    Automated = true
  }
}