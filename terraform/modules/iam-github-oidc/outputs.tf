output "gha_terraform_role_arn" {
  value = aws_iam_role.gha_terraform.arn
}

output "gha_ecr_push_role_arn" {
  value = aws_iam_role.gha_ecr_push.arn
}
