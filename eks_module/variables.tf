variable "access_key" {
    default = ""
}

variable "secret_key"{
    default= ""
}

variable "region" {
    default = "ap-south-1" 
}
variable "aws_eks_cluster_config" {
  type = map(object({
    eks_cluster_name = string
    eks_subnet_ids   = list(string)
    tags             = map(string)
  }))

  default = {
    cluster = {
      eks_cluster_name = "AWS-EKS"
      eks_subnet_ids   = ["subnet-00e26cf0cba22eea3","subnet-0e07a2e12866908e4"]
      # eks_subnet_ids = module.eks_vpc.EKS_Public_Subnet
      tags             = {
        Environment = "dev"
        Owner       = "Maroof"
      }
    }
  }
}

variable "eks_node_group_config" {
  type = map(object({
    node_group_name = string
    eks_cluster_name = string
    node_subnet_ids = list(string)
    nodes_iam_role  = string
    tags            = map(string)
  }))

  default = {
    cluster_node = {
      node_group_name = "AWS-EKS-NODEGROUP"
      eks_cluster_name = "AWS-EKS"
      node_subnet_ids   = ["subnet-00e26cf0cba22eea3","subnet-0e07a2e12866908e4"]
      nodes_iam_role  = "arn:aws:iam::637828493305:role/eks_nodegroup"
      tags             = {
        Environment = "dev"
        Owner       = "Maroof"
      }
    }
  }
}
