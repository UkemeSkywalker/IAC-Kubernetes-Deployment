#!/bin/bash

# Initialize Terraform
terraform init

# Apply Terraform Configuration (Creates EKS Cluster and Kubernetes Resources)
terraform apply -auto-approve

# Wait for EKS Cluster to be Ready
CLUSTER_NAME="xyz-eks-cluster"  
REGION="us-west-1"        

echo "Waiting for EKS cluster $CLUSTER_NAME to be ready..."

# Wait until the cluster status becomes "ACTIVE"
while [ "$(aws eks describe-cluster --name $CLUSTER_NAME --region $REGION --query 'cluster.status')" != "\"ACTIVE\"" ]; do
    echo "Cluster not yet ready. Sleeping for 30 seconds..."
    sleep 30
done

echo "EKS cluster $CLUSTER_NAME is ready."

# Apply Kubernetes Manifests (Deployment, Service, etc.)
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
