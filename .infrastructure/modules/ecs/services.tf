resource "aws_ecs_service" "api" {
  name = "${var.cluster_name}-service"
  task_definition = aws_ecs_task_definition.api.arn
  cluster = aws_ecs_cluster.cluster.id
  launch_type = "FARGATE"
  desired_count = var.desired_tasks

  network_configuration {
    security_groups = var.security_groups_ids
    subnets          = concat(var.public_subnet_1a, var.public_subnet_1b)
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.api_target_group.arn
    container_name = var.container_name
    container_port = var.container_port
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition]
  }

  depends_on = [
    aws_alb_target_group.api_target_group]
}