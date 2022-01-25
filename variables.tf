variable "region" {
  default     = "us-west-2"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "demo"
  description = "EKS cluster name"
}

variable "email_id" {
  description = "Email ID to sent cloudwatch alarms to."
}