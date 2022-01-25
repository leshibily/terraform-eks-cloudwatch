module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.2.3"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  # subnet_ids      = module.vpc.private_subnets
  subnet_ids = module.vpc.public_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    root_volume_type = "gp2"
    ami_type         = "AL2_x86_64"
    disk_size        = 20
  }

  eks_managed_node_groups = [
    {
      launch_template_name          = "worker-group-1"
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity          = 1
    }
  ]
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  cluster_name = "${var.cluster_name}-${random_string.suffix.result}"
  kubeconfig   = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.cluster_endpoint}
    certificate-authority-data: ${module.eks.cluster_certificate_authority_data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}-${random_string.suffix.result}"
KUBECONFIG
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}