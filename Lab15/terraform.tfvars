aws_region    = "us-west-2"
port_list     = ["80", "443", "8443"]
instance_size = "t2.micro"
aws_ami_owner = ["137112412989"]

tags = {
  Owner       = "Danilo Cairolli"
  Environment = "Project"
  Project     = "Phoenix"
  Code        = "445555"
}