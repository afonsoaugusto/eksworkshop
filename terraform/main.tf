variable "name" {
  type        = string
  default     = "eks-workshop"
  description = "description"
}

locals {
  tags = {
    Name  = var.name
    Tribo = "Infrastructure"
    Onwer = "Afonso"
  }
}

output "name" {
  value       = var.name
  description = "description"
}

output "tags" {
  value       = local.tags
  description = "description"
}

resource "aws_kms_key" "eks" {
  description = "EKS Secret Encryption Key"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.name
  cluster_version = "1.19"
  subnets         = data.aws_subnet_ids.subnets.ids
  vpc_id          = data.aws_vpc.vpc.id
  # manage_aws_auth = false

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
    }
  ]

  worker_groups = [
    {
      name                 = "worker-group-1"
      instance_type        = "t3.small"
      asg_desired_capacity = 2
      root_volume_type     = "standard"
    },
    {
      name                 = "worker-group-2"
      instance_type        = "t3.medium"
      asg_desired_capacity = 1
      root_volume_type     = "standard"
    },
  ]
  tags = local.tags
}

# data "aws_eks_cluster" "cluster" {
#   name = module.my-cluster.cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.my-cluster.cluster_id
# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }
