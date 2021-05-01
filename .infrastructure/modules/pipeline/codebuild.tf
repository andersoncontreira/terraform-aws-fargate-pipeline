resource "aws_codebuild_project" "app_project" {
  name = var.cluster_name
  build_timeout = "60"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    // If set to true, enables running the Docker daemon inside a Docker container.
    privileged_mode = true

    environment_variable {
      name = "ACCOUNT_ID"
      value = var.account_id
    }

    environment_variable {
      name = "SECRET_KEY"
      value = replace(file("../.env"),"SECRET_KEY=", "")
    }

    environment_variable {
      name = "DJANGO_DEBUG"
      value = false
    }

  }

  source {
    type = "CODEPIPELINE"

    git_submodules_config {
      fetch_submodules = false
    }
  }

  // TODO futuramente aplicar a VPC criada para esta finalidade
  //  vpc_config {
  //    vpc_id = aws_vpc.example.id
  //
  //    subnets = [
  //      aws_subnet.example1.id,
  //      aws_subnet.example2.id,
  //    ]
  //
  //    security_group_ids = [
  //      aws_security_group.example1.id,
  //      aws_security_group.example2.id,
  //    ]
  //  }

  tags = {
    Environment = "Production"
  }
}