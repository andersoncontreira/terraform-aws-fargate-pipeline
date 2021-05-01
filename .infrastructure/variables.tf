variable "account_id" {
}

variable "project_name" {
  type = string
  default = "standard-manager-api"
}

variable "aws_profile" {
  type    = string
  default = "tcc-td-puc-minas-admin"
}

variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "aws_codepipeline_organization_id" {
  default = "tcc-td-puc-minas-indtexbr"
}

# -----------------------------------
#
# -----------------------------------
# Listener Application Load Balancer Port
variable "alb_port" {
  description = "Origin Application Load Balancer Port"
  default     = "80"
}

# Target Group Load Balancer Port
variable "container_port" {
  description = "Destination Application Load Balancer Port"
  default     = "8000"
}

# ------------------------------------
# Sensitive variables
# ------------------------------------
variable "aws_codebuild_role_arn" {
  default = ""
}

variable "aws_codedeploy_role_arn" {
  default = ""
}

variable "aws_codepipeline_bucket" {
  default = ""
}

variable "aws_codepipeline_bucket_resource" {
  default = "arn:aws:s3:::codepipeline-sa-east-1-*"
}

variable "aws_codestar_connection_name" {
  default = "tcc-td-puc-minas-indtexbr"
}