output "tfstate_bucket" {
  value       = aws_s3_bucket.tfstate.bucket
  description = "Paste this into envs/dev/providers.tf backend block"
}

output "tflock_table" {
  value       = aws_dynamodb_table.tflock.name
  description = "DynamoDB table name for state locking"
}