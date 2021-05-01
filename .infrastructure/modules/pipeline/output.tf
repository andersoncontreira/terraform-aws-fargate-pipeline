output "pipeline_name" {
  value = aws_codepipeline.codepipeline.name
}

output "codebuild_name" {
  value = aws_codebuild_project.app_project.name
}