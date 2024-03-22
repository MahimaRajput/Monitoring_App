provider "aws"{
    version = "~> 5.42.0"
    region = "us-east-1"
}

resource "aws_ecr_repository" "monitoring_app" {
  name = "monitoring_app"
}


resource "aws_eks_cluster" "monitor_cluster" {
  name     = "monitor_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = ["subnet-08d94184c2fa09560"]  # Add your subnet IDs
    security_group_ids = ["sg-0050636b4e8b08d56"]                         # Add your security group ID
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "my-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}
