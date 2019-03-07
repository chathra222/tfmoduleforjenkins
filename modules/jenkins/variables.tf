variable "ssh_port" {
  description = "The port used for SSH connections"
  default     = 22
}

variable "http_port" {
  description = "The port to use for HTTP traffic to Jenkins"
  default     = 8080
}

variable "https_port" {
  description = "The port to use for HTTPS traffic to Jenkins"
  default     = 443
}

variable "jnlp_port" {
  description = "The port to use for TCP traffic between Jenkins intances"
  default     = 49187
}

variable "allowed_inbound_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connections to Jenkins"
  type        = "list"
}

variable "allowed_ssh_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connections on SSH"
  type        = "list"
}

variable "setup_data" {
  description = "Setup Script"
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instance"
  default     = ""
}

variable "ssh_key_path" {
  description = "The path of an EC2 Key Pair that can be used to SSH"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "user_data" {
  default = ""
}

variable "ami_id" {
}

variable "name" {
  default = "Jenkins Server"
}
