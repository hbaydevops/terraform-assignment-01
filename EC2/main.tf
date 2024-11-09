# Specify the provider
provider "aws" {
  region = "us-east-1" # Ensure this is the region where your resources are located
}

## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Define the EC2 instance
resource "aws_instance" "example_instance" {
  ami                    = "ami-0984f4b9e98be44bf"  # Confirm this AMI exists in us-east-1
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0529e6efe71cdb035" # Ensure this subnet is in us-east-1
  vpc_security_group_ids = ["sg-02840ef3d2c5a30af"]   # Ensure this security group is in us-east-1

  # Specify the existing key pair name
  key_name = "terraform-key" # Ensure this key pair exists in us-east-1

  tags = {
    Name = "terraform-EC2-01"
  }
}

# Output the instance's public IP
output "instance_public_ip" {
  value       = aws_instance.example_instance.public_ip
  description = "The public IP of the instance"
}
