variable "aws_region" {
  type    = string
  default = "us-east-1"  # Can be overridden by terraform.tfvars
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "public_key_path" {
  description = "Path to your SSH public key"
  type        = string
}
