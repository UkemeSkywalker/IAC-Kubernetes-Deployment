#!/bin/bash

# Initialize Terraform
terraform init

# Apply Terraform Configuration (Creates EKS Cluster and Kubernetes Resources)
terraform apply -auto-approve

# # Retrieve EKS Cluster Name and Region from Terraform Output
EKS_CLUSTER_NAME=$(terraform output eks_cluster_name)
AWS_REGION=$(terraform output aws_region)

# # Configure kubectl with AWS CLI
aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

# Apply Kubernetes Manifests (Deployment, Service, etc.)
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
