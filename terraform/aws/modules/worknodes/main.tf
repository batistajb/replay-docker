resource "aws_eks_node_group" "replay_app_nodegroup" {
  cluster_name    = var.cluster_name
  node_group_name = "${local.node_name}-${count.index}"
  node_role_arn   = aws_iam_role.replay-app-eks-node-role.arn
  instance_types  = ["t2.micro"]

  count = var.worknodes

  subnet_ids = var.eks_subnet_ids

  scaling_config {
    desired_size = var.worknode_desired_size
    max_size     = var.worknode_max_size
    min_size     = var.worknode_min_size
  }
  
  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.replay-app-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.replay-app-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.replay-app-AmazonEC2ContainerRegistryReadOnly,
  ]
}