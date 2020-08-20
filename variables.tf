variable "instance" {
  description = "This variable state the instance type for your EC2"
  default     = "t2.micro"
}

variable "region" {
  description = "This variable state the region of the instance"
  default     = "eu-west-1"

}

variable "ami" {
  description = "This variable state the ami ID"
  default     = "ami-07ee42ba0209b6d77"
}

variable "key_name" {
  description = "This variable state key pair name"
  default     = "AWSQA"
}

variable "cidr_block" {
  description = "cidr block"
  default     = "192.168.0.0/16"
}

variable "sn_cidr_block" {
  default = "192.168.1.0/24"
}
