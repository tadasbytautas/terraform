variable "instance" {
  description = "This variable state the instance type for your EC2"
  default     = "t2.micro"
}

variable "ami" {
  description = "This variable state the ami ID"
  default     = "ami-07ee42ba0209b6d77"
}

variable "key_name" {
  description = "This variable state key pair name"
  default     = "AWSQA"
}