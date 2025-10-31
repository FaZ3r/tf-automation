variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access"
  type        = string
}

variable "current_region" {
  default = "eu-west-2"
  type = string
  description = "Current region, defaults to eu-west-2"
}