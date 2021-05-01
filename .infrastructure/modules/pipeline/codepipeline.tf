locals {
  aws_codepipeline_name = var.cluster_name
  aws_codepipeline_repository_id = join("/", [
    var.aws_codepipeline_organization_id,
    var.cluster_name])
}


resource "aws_codepipeline" "codepipeline" {
  name = local.aws_codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeStarSourceConnection"
      version = "1"
      namespace = "SourceVariables"
      output_artifacts = [
        "SourceArtifact"]

      configuration = {
        ConnectionArn = aws_codestarconnections_connection.connection.arn
        FullRepositoryId = local.aws_codepipeline_repository_id
        BranchName = var.aws_codepipeline_branch_name
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      namespace = "BuildVariables"
      input_artifacts = [
        "SourceArtifact"
      ]
      output_artifacts = [
        "BuildArtifact"
      ]
      configuration = {
        ProjectName = var.cluster_name
      }
    }
  }
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      namespace      = "DeployVariables"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        ClusterName = join("-", [var.cluster_name, "cluster"])
        ServiceName = join("-", [var.cluster_name, "service"])
        FileName    = "imagedefinitions.json"
      }
    }
  }
}



