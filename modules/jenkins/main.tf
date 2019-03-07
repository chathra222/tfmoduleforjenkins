data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default_vpc_subnets" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_subnet" "jenkins_subnet" {
  id    = "${data.aws_subnet_ids.default_vpc_subnets.ids[1]}"
}

resource "aws_security_group" "jenkins_security_group" {
  name_prefix = "jenkins_security_group"
  description = "Security group for the jenkins"
  vpc_id      = "${data.aws_vpc.default.id}"
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type        = "ingress"
  from_port   = "${var.ssh_port}"
  to_port     = "${var.ssh_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_ssh_cidr_blocks}"]

  security_group_id = "${aws_security_group.jenkins_security_group.id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.jenkins_security_group.id}"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type        = "ingress"
  from_port   = "${var.http_port}"
  to_port     = "${var.http_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${aws_security_group.jenkins_security_group.id}"
}

resource "aws_security_group_rule" "allow_https_inbound" {
  type        = "ingress"
  from_port   = "${var.https_port}"
  to_port     = "${var.https_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${aws_security_group.jenkins_security_group.id}"
}

resource "aws_security_group_rule" "allow_jnlp_inbound" {
  type        = "ingress"
  from_port   = "${var.jnlp_port}"
  to_port     = "${var.jnlp_port}"
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${aws_security_group.jenkins_security_group.id}"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.jenkins.id}"
  allocation_id = "${aws_eip.eip.id}"
}

resource "aws_instance" "jenkins" {
  count                  = 1
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  key_name               = "${var.ssh_key_name}"
  vpc_security_group_ids = ["${aws_security_group.jenkins_security_group.id}"]
  subnet_id = "${data.aws_subnet.jenkins_subnet.id}"

  provisioner "file" {
    connection  = {
      user = "ec2-user"
      private_key = "${file(var.ssh_key_path)}"
    }
    content     = "${var.setup_data}"
    destination = "/tmp/setup.sh"
  }

  provisioner "remote-exec" {
    connection  = {
      user = "ec2-user"
      private_key = "${file(var.ssh_key_path)}"
    }
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh"
    ]
  }

  tags = {
   Name = "${var.name}"
 }
}

resource "aws_eip" "eip" {
  vpc = true
  instance                  = "${aws_instance.jenkins.id}"
}
