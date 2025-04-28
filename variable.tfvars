# terraform.tfvars
instance_type = "t2.small"
ec2_ami       = "ami-0e449927258d45bc4"




variable "ami" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0e449927258d45bc4"
}




// 129.222.206.25


variable "MY_STARLINK" {
  description = "my ip"
  type        = string
  default     = "129.222.206.25"
}
