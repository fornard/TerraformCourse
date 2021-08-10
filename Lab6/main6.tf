# Build WebServer during Bootstrap with External STATIC File
# ElasticIP and Lifecycle to reduce Downtime


provider "aws" {
    region = "us-west-2"
  
}

resource "aws_eip" "WebEip"{
  instance=aws_instance.My_Ubuntu_LAB2.id
  tags = {
    Name = "TerraformTraining"
    Owner = "Danilo Fornari"
    Project = "LAB2"
  }
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
  lifecycle{
    create_before_destroy = true
  }
}

resource "aws_security_group" "TerraformCourse" {
  name        = "WebServer-LAB"
  description = "Security Group for my WebServer_LAB2"

  ingress {
    description = "Allow port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow port HTTPS"
    from_port   = 443
    to_port     = 443
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
    Name = "TerraformTraining"
    Owner = "Danilo Fornari"
    Project = "LAB2"
  }
}
