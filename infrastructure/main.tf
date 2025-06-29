# Terraform configuration with security issues for ASH testing

terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Security issue: S3 bucket without encryption
resource "aws_s3_bucket" "example" {
  bucket = "ash-test-bucket-${random_string.bucket_suffix.result}"
}

resource "random_string" "bucket_suffix" {
  length  = 5
  special = false
  upper   = false
}

# Security issue: Security group allows all traffic
resource "aws_security_group" "web" {
  name_prefix = "ash-test-"
  
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Security issue: open to world
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security issue: EC2 instance without encryption
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1d0"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.web.id]
  
  # Security issue: no encryption at rest
  root_block_device {
    volume_size = 20
    encrypted   = false
  }
  
  tags = {
    Name = "ash-test-instance"
  }
}
