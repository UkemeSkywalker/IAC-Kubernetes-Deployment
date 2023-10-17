output "eks_cluster_name" {
  value = aws_eks_cluster.xyz_cluster.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.xyz_cluster.endpoint
}

output "eks_cluster_security_group_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
