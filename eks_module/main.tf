
# data "aws_subnet_ids" "Private_subnet" {
#   vpc_id = data.aws_vpc.EKS_VPC
#   tags = {
#     type = "Private"
#   }
# }
# data "aws_subnet_ids" "Private_subnet" {
#   vpc_id = aws_vpc.EKS_VPC.id
#   tags = {
#     type = Private
#   }
# }
module "eks_vpc" {
  source = "./modules/aws_vpc"
}

module "aws_eks_cluster" {

   source = "./modules/aws_eks"
  
   for_each = var.aws_eks_cluster_config

    eks_cluster_name              = each.value.eks_cluster_name 
    subnet_ids                    = each.value.eks_subnet_ids
    tags                          = each.value.tags
}

module "aws_eks_node_group" {

   source = "./modules/aws_eks_nodegroup"

   depends_on = [ module.aws_eks_cluster ]
  
   for_each = var.eks_node_group_config

    node_group_name               = each.value.node_group_name
    eks_cluster_name              = each.value.eks_cluster_name
    subnet_ids                    = each.value.node_subnet_ids
    nodes_iam_role                = each.value.nodes_iam_role
    tags                          = each.value.tags
}