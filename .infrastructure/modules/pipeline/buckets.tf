resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = var.aws_codepipeline_bucket
  acl = "private"
}