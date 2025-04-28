



// my ec2 instance
resource "aws_instance" "web" {
  ami           = var.ami,id
  instance_type = "t3.micro"

  tags = {
    Name = "travel_server"
  }
}


// my VPC config
resource "aws_vpc" "vpc_travel" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_travel"
  }
}

// s3 bucket config
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "s3-bucket-travel"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}



// security group config
resource "aws_security_group" "SG_travel" {
  name        = "SG_open"
  description = "for my travel webapp"
  vpc_id      = aws_vpc.vpc_travel.id
  tags = {
    Name = "SG_travel"
  }
}


//inbound rule for security group
resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.SG_travel.id
  cidr_ipv4         = var.my_ips.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

//ELB config
// Create a new load balancer
# resource "aws_elb" "elb" {
#   name               = "foobar-terraform-elb"
#   availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
#
#   access_logs {
#     bucket        = "foo"
#     bucket_prefix = "bar"
#     interval      = 60
#   }
#
#   listener {
#     instance_port     = 8000
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }
#
#   listener {
#     instance_port      = 8000
#     instance_protocol  = "http"
#     lb_port            = 443
#     lb_protocol        = "https"
#     ssl_certificate_id = "arn:aws:acm:us-east-1:721912316979:certificate/373a6f7e-1804-4d48-844e-d2f8b617e0d2"
#   }
#
#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "HTTP:8000/"
#     interval            = 30
#   }
#
#   instances                   = [aws_instance.web.id]
#   cross_zone_load_balancing   = true
#   idle_timeout                = 400
#   connection_draining         = true
#   connection_draining_timeout = 400
#
#   tags = {
#     Name = "foobar-terraform-elb"
#   }
# }
#


