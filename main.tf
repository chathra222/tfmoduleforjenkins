provider "aws" {
  region = "${var.region}"
  access_key ="${var.access_key}"
  secret_key ="${var.secret_key}"

}

data "template_file" "setup_data_master" {
 template = "${file("./modules/jenkins/setup.tpl")}"

}


module "jenkins-master" {
  source                      = "./modules/jenkins"

  name                        = "Jenkins Server"
  instance_type               = "${var.instance_type}"

  ami_id                      = "${var.ami_id}"
  user_data                   = ""
  setup_data                  = "${data.template_file.setup_data_master.rendered}"

  http_port                   = "${var.http_port}"
  allowed_ssh_cidr_blocks     = ["0.0.0.0/0"]
  allowed_inbound_cidr_blocks = ["0.0.0.0/0"]
  ssh_key_name                = "${var.ssh_key_name}"
  ssh_key_path                = "${var.ssh_key_path}"


}
