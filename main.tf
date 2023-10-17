provider "aws" {
  region = "us-west-1"  # Set your desired AWS region
}

resource "aws_eks_cluster" "xyz_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.21"  # Set your desired Kubernetes version

  vpc_config {
    subnet_ids = aws_subnet.private.*.id
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

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

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  count                   = 2  # Set the number of private subnets
  cidr_block              = "10.0.1${count.index}.0/24"  # Set your desired CIDR block
  availability_zone       = "us-west-1a"  # Set your desired availability zone
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-${count.index}"
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

