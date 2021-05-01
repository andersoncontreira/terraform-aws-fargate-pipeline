variable "aws_region" {
}

variable "account_id" {
}

variable "cluster_name" {
}

variable "aws_codepipeline_organization_id" {
}

variable "aws_codepipeline_bucket" {
}

variable "aws_codepipeline_branch_name" {
  default = "master"
}

variable "codestar_connection_name" {
  type = string
  description = "Codestar connection name for github"
}

variable "codestar_provider_type" {
  type = string
  description = "Provider"
  default = "GitHub"
}

