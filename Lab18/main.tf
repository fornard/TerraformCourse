#----------------------------------------------------------
# Execute Commands on Remote Server
#----------------------------------------------------------
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "latest_image"{
    owners = var.AMI_owner
    most_recent = true
    filter{
        name = "name"
        values = var.AMI_Name
    }
}

resource "aws_instance" "myserver" {
  ami                    = data.aws_ami.latest_image.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = "Danilo_Terraform"
  tags = {
    Name  = "My EC2 with remote-exec"
    Owner = "Danilo Fornari"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ec2-user/terraform",
      "cd /home/ec2-user/terraform",
      "touch hello.txt",
      "echo 'Terraform was here...' > terraform.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip //Same as: aws_instance.myserver.public_ip
      private_key = file(var.PEM_KEY)
    }
  }
}


resource "aws_security_group" "web" {
  name = "My-SecurityGroup"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "SG by Terraform"
    Owner = "Danilo Fornari"
  }
}