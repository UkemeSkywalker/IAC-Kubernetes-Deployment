output "eks_cluster_name" {
  value = aws_eks_cluster.xyz_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.xyz_cluster.endpoint
}

output "eks_cluster_security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "private_subnet_az1" {
  value = aws_subnet.private_subnet_az1.id
}

output "private_subnet_az2" {
  value = aws_subnet.private_subnet_az2.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

# output "load_balancer_endpoint" {
#   value = shellscript("kubectl get service my-app-service -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}'")
# }
