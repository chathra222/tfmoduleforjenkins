# tfmoduleforjenkins

Prerequisite
-------------
Terraform,GIT should be installed in Terraform execution server.

Note
-----
* I am using default VPC to setup Jenkins Server

* Step to run

    1)Clone the code to terraform execution server

    2)Set necessary variables in variables.tf file

    Mandatory variables to be set (You can set the default value of each variable or can define in a tfvars file and pass the file in command line)
    -----------------------------
        ami_id - id of AMI (Use Redhat, Centos or Fedora)
        ssh_key_name - name of the EC2 Key Pair that can be used to SSH  
        ssh_key_path - The path of an EC2 Key Pair that can be used to SSH (which should placed in terraform execution server)
        instance_type - instance_type (default-t2.micro)
        access_key- Access key of the user which has sufficient permissions to create resources in AWS
        secret_key- Secret key of the user which has sufficient permissions to create resources in AWS

    2)Run "terraform init" command

    3)Run "terraform plan" to dry run

    4)Run "terraform apply"

    5) Access Jenkins 
    http://<public DNS or Elastic IP>:8080
