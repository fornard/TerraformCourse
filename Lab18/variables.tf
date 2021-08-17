variable "AMI_owner" {
    description = "AMI for machine"
    type = list(any)
    default = ["137112412989"]
  
}

variable "AMI_Name" {
    description = "AMI for machine"
    type = list(any)
    default = ["amzn2-ami-hvm-*-x86_64-gp2"]
  
}

variable "PEM_KEY" {
    description = "SSH KEY PATH"
    type = string
    default = "Danilo_Terraform.pem"
  
}