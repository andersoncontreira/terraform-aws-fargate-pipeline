
module "vpc" {
  source = "modulesvpc"
  cluster_name = var.project_name
  alb_port       = var.alb_port
  container_port = var.container_port
}

module "ecs" {
  source              = "modulesecs"
  cluster_name        = var.project_name
  app_repository_name = var.project_name
  container_name      = var.project_name
  container_port      = var.container_port
  alb_port            = var.alb_port
  vpc_id              = module.vpc.vpc_id
  region = var.aws_region

  public_subnet_1a    = module.vpc.public_subnet_1a
  public_subnet_1b    = module.vpc.public_subnet_1b
  app_sg_id           = module.vpc.app_sg_id
  alb_sg_id           = module.vpc.alb_sg_id
  ecs_sg_id           = module.vpc.ecs_sg_id

//  min_tasks           = "${var.min_tasks}"
//  max_tasks           = "${var.max_tasks}"
//  cpu_to_scale_up     = "${var.cpu_to_scale_up}"
//  cpu_to_scale_down   = "${var.cpu_to_scale_down}"
//  desired_tasks       = "${var.desired_tasks}"
//  desired_task_cpu    = "${var.desired_task_cpu}"
//  desired_task_memory = "${var.desired_task_memory}"
//
  security_groups_ids = [
    module.vpc.app_sg_id,
    module.vpc.alb_sg_id,
    module.vpc.ecs_sg_id,
  ]

  availability_zones = [
    module.vpc.public_subnet_1a,
    module.vpc.public_subnet_1b
  ]

}

module "pipeline" {
  source = "modulespipeline"
  codestar_connection_name = var.aws_codestar_connection_name

  account_id = var.account_id
  aws_region = var.aws_region
  cluster_name = var.project_name
  aws_codepipeline_bucket = var.aws_codepipeline_bucket
  aws_codepipeline_organization_id = var.aws_codepipeline_organization_id
}