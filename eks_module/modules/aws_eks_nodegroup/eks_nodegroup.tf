resource "aws_eks_node_group" "eks_nodegroup" {
    cluster_name = var.eks_cluster_name
    node_group_name   = var.node_group_name
    node_role_arn = aws_iam_role.eks_node_group.arn
    subnet_ids =  var.subnet_ids
    scaling_config {
        desired_size         =  1
        max_size             =  1
        min_size             =  1
    }
    ami_type = "AL2_x86_64"
    capacity_type = "ON_DEMAND"
    disk_size = 20
    force_update_version = false
    instance_types     = ["t2.medium"]
    version = "1.24"

    depends_on = [ 
        aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
        aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    ]
    tags = {
      name = "eks_node_policy"
    }
}
resource "aws_iam_role" "eks_node_group" {
  name = var.node_group_name

  # The policy that grants an entity permission to assume the role.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role    = aws_iam_role.eks_node_group.name

}

# resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.eks_nodegroup.name
# }

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.eks_node_group.name
}

# resource "aws_key_pair" "deployer" {
#   key_name   = "id_rsa"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6XfmmwpZeoNnJ+SQKACrIuU9ac53Izyl1rqs/5Ayo+07/wUkzWLfAGDcg8XPYJy0kXQn7uQZcooJ5EuPPS3GIt+Mmweezt6RWNjDnTgMxbC/4hWGp2uGzHQre2XXHCzBZa87sq325owbCpzVU24QkcRxvHSAmt/KDi5lJIiKB4VksOF6BCugjBnvtiV0Wnd8m1BV7dF7cJwRbciyJKoJ9oNDIECPIeMHwIQqIQGJINRatAGScrdjkqR09mxNpLAFBkSpt3nUubdmaU8YdVD/xss4QlekifOJai5FvPS3wDi+urXPh8vJKKallG6tj5KDGa23Z+OSeeINFaWAxvVZSgSQTrow84fN276BylDh4KIAatOdInswgI0dYRcZ7b+4EXfkJHPqxmXzt/nqUvC1jQy2R5cJswqZ+/uUQRK/RuwNmLqvPb0tCXhat+mMqcOqDl6pjYTq4gGMbypjHWFt1CKJ5Z11kH4vDcOmr4btpOPHr/riR8FH+CNZwANtoqcM= maroof@DESKTOP-P22AOUS"
# }