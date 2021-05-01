data "template_file" "codepipeline_policy" {
  template = file("${path.module}/templates/policies/codepipeline_policy.json")

  vars = {
    aws_s3_bucket_arn = aws_s3_bucket.codepipeline_bucket.arn
  }
}

data "template_file" "codebuild_policy" {
  template = file("${path.module}/templates/policies/codebuild_policy.json")

  vars = {
    aws_s3_bucket_arn = aws_s3_bucket.codepipeline_bucket.arn
    aws_region = var.aws_region
    account_id = var.account_id
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-${var.cluster_name}-role"

  assume_role_policy = file("${path.module}/templates/policies/codepipeline_role.json")
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline-${var.cluster_name}-policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.template_file.codepipeline_policy.rendered
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-${var.cluster_name}-role"

  assume_role_policy = file("${path.module}/templates/policies/codebuild_role.json")

}


resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "codebuild-${var.cluster_name}-policy"
  role   = aws_iam_role.codebuild_role.id
  policy = data.template_file.codebuild_policy.rendered
}

