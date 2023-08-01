locals {
  tags = {
    Name = "EKS_CLUSTER"
    Environment = "Development"
    createdby = "Terraform"
  }
}

variable "subnet_ids" {
  default =["subnet-0318d2474c4ffafe2","subnet-0fe4d084e06bf0b48"]
  
}

# variable "name" {
#   default = "EKS"
# }

variable "eks_cluster_name" {
  default = "EKS"
}

variable "tags" {
  default = "eks_policy"
}