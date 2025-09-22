variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access"
  type        = string
}

variable "security_group_id" {
  description = "ID of an existing Security Group to associate with the EC2 instance"
  type        = string
}