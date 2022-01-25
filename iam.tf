resource "aws_iam_role_policy_attachment" "additional" {
  for_each   = module.eks.eks_managed_node_groups
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = each.value.iam_role_name
}