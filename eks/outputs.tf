output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "AccessKey" {
  description = "AWS Access Key ID"
  type        = string
  value       = var.AccessKey
  sensitive   = true
}

output "SecretKey" {
  description = "AWS Secret Access Key"
  type        = string
  value       = var.SecretKey
  sensitive   = true
}
