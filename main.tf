provider "aws" {
  region = "us-east-1"  
}

resource "aws_eks_cluster" "xyz_cluster" {
  name     = "xyz-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [aws_subnet.private_subnet_az1.id, aws_subnet.private_subnet_az2.id ]
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role-tf2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_subnet" "private_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"  # Set your desired CIDR block
  availability_zone       = "us-east-1a"  # Set your desired availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-us-east-1a"
  }
}

resource "aws_subnet" "private_subnet_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"  # Set your desired CIDR block
  availability_zone       = "us-east-1b"  # Set your desired availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-us-east-1b"
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "EKS Cluster Security Group"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this to your specific IP range for security
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # Set your desired VPC CIDR block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

