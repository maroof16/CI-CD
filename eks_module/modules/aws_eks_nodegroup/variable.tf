locals {
  tags = {
    Name = "EKS_NODEGROUP"
    Environment = "Development"
    createdby = "Terraform"
  }
}

variable "eks_cluster_name" {
  type = string
  # default = "AWS-EKS"
}

variable "node_group_name" {
  default = "eks_nodegroup"
}
variable "subnet_ids" {
  default = ["subnet-0318d2474c4ffafe2"]
}

variable "tags" {
  default = "eks_node_policy"
    
}

variable nodes_iam_role {
  type        =  string
}