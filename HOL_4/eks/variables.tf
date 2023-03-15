variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "AccessKey" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "SecretKey" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}