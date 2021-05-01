variable "region" {
  default = ""
}

variable "cluster_name" {
  description = "The cluster_name"
}

variable "app_repository_name" {
  description = "Name of ECR Repository"
}

variable "container_name" {
  description = "Container name"
}

variable "container_port" {
  description = "ALB target port"
}

variable "alb_port" {
  description = "ALB listener port"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "availability_zones" {
  type        = list
  description = "The azs to use"
}

variable "security_groups_ids" {
  type        = list
  description = "Security group lists"
}

variable "public_subnet_1a" {
  description = "Public Subnet on sa-east-1a"
}

variable "public_subnet_1b" {
  description = "Public Subnet on sa-east-1b"
}

variable "app_sg_id" {
  description = "App Security Group"
}

variable "alb_sg_id" {
  description = "Application Load Balancer Security Group"
}

variable "ecs_sg_id" {
  description = "ECS Security Group"
}

variable "desired_tasks" {
  description = "Number of containers desired to run the application task"
  default = 2
}

variable "min_tasks" {
  description = "Minimum"
  default = 2
}

variable "max_tasks" {
  description = "Maximum"
  default = 4
}

variable "cpu_to_scale_up" {
  description = "CPU % to Scale Up the number of containers"
  default     = 80
}

variable "cpu_to_scale_down" {
  description = "CPU % to Scale Down the number of containers"
  default     = 30
}

# Desired CPU
variable "desired_task_cpu" {
  description = "Desired CPU to run your tasks"
  default     = "256"
}

# Desired Memory
variable "desired_task_memory" {
  description = "Desired memory to run your tasks"
  default     = "512"
}

variable "desired_task_memory_reservation" {
  description = "Desired memory reservation to run your tasks"
  default     = "300"
}