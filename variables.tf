variable "http_port" {
  default = "8080"
}
variable "instance_type" {
  default = "t2.micro"
}
//Use RedHat AMI
variable "ami_id" {
  default = ""
}
//Key pair name
variable "ssh_key_name" {
  default = ""
}
//path to .pem file
variable "ssh_key_path" {
  default = ""
}

//aws access key
variable "access_key" {
  default = ""
}

//your aws secret_key
variable "secret_key" {
  default = ""
}

variable "region" {
  default = "us-east-1"
}
