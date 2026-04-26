output "cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name — used in aws eks update-kubeconfig"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "Kubernetes API server endpoint"
}

output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "OIDC provider ARN — needed for IRSA role creation"
}

output "ecr_repository_urls" {
  value       = module.ecr.repository_urls
  description = "Map of service name → ECR URL"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
