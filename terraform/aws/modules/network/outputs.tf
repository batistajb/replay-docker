output "vpc_id" {
  value = aws_vpc.replay_app_private_vpc.id
}

output "eks_subnet_ids" {
  value = aws_subnet.replay-app-eks-subnet.*.id
}

output "cluster_name" {
  value = local.cluster_name
}