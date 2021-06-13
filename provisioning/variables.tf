variable "ansible_instance_type" {
  type        = string
  description = "The instance type."
  default     = "t2.medium"
}

variable "ansible_count" {
  type        = number
  description = "The number of machines."
  default      = 1
}

variable "key_path" {
  type        = string
  description = "The complete path that contain ssh private key."
  default     = "~/.ssh/id_rsa"
}

variable "key_name" {
  type        = string
  description = "Key name that will be created in AWS."
  default     = "id_rsa"
}

variable "user_ec2" {
  type        = string
  description = "The user to connect on EC2 instance."
  default     = "ubuntu"
}