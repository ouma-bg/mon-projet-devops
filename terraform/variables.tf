variable "aws_region" {
  default = "eu-west-3"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c1a7f89451184c8b"
}

variable "key_name" {
  description = "Nom de la key pair EC2 existante"
  type        = string
}