# S3 Bucket for Artifacts
output "aws_s3_bucket_id" {
  value = aws_s3_bucket.this.aws_s3_bucket_id
}

output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.this.aws_s3_bucket_arn
}

output "aws_s3_bucket_bucket_domain_name" {
  value = aws_s3_bucket.this.aws_s3_bucket_bucket_domain_name
}

output "aws_s3_bucket_bucket_regional_domain_name" {
  value = aws_s3_bucket.this.aws_s3_bucket_bucket_regional_domain_name
}

output "aws_s3_bucket_hosted_zone_id" {
  value = aws_s3_bucket.this.aws_s3_bucket_hosted_zone_id
}

output "aws_s3_bucket_region" {
  value = aws_s3_bucket.this.aws_s3_bucket_region
}

# IAM Role for CodeBuild
output "aws_codebuild_service_role_arn" {
  value = aws_iam_role.codebuild_service_role.aws_codebuild_service_role_arn
}

# CodeBuild
output "aws_codebuild_project_arn" {
  value = aws_codebuild_project.this.aws_codebuild_project_arn
}

output "aws_codebuild_project_badge_url" {
  value = aws_codebuild_project.this.aws_codebuild_project_badge_url
}

output "aws_codebuild_project_id" {
  value = aws_codebuild_project.this.aws_codebuild_project_id
}

# IAM Role for CodePipeline
output "aws_codepipeline_service_role_arn" {
  value = aws_iam_role.codepipeline_service_role.aws_codepipeline_service_role_arn
}

# CodePipeline
output "aws_codepipeline_id" {
  value = aws_codepipeline.this.aws_codepipeline_id
}

output "aws_codepipeline_arn" {
  value = aws_codepipeline.this.aws_codepipeline_arn
}