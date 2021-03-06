provider "aws" {
    region = "us-west-2"
  
}

resource "aws_instance" "My_Ubuntu_LAB2" {
  ami           = "ami-083ac7c7ecf9bb9b0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TerraformCourse.id]
  user_data = templatefile("template.sh.tpl", {
    f_name = "Danilo"
    l_name = "Fornari"
    names = ["Danilo, Vanessa, Renato"]
  })

  tags = {
    Name = "TerraformTraining"
    Owner = "Danilo Fornari"
    Project = "LAB2"
  }
}

resource "aws_security_group" "TerraformCourse" {
  name        = "WebServer-LAB"
  description = "Security Group for my WebServer_LAB2"

  dynamic "ingress"{
    for_each = ["80", "443"]
    content{
      description = "Allow port TCP"
      from_port = ingress.value
      to_port = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraformTraining"
    Owner = "Danilo Fornari"
    Project = "LAB2"
  }
}
