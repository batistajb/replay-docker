# Cluster initial setup
resource "aws_eks_cluster" "replay_app_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.replay-app-eks-cluster-role.arn
  version  = "1.31"

  tags = var.tags

  vpc_config {
    subnet_ids = var.eks_subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.replay-app-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.replay-app-AmazonEKSServicePolicy,
  ]
}