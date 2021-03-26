# S3 Bucket for Artifacts
output "aws_s3_bucket_id" {
  value = module.codepipeline.aws_s3_bucket_id
}

output "aws_s3_bucket_arn" {
  value = module.codepipeline.aws_s3_bucket_arn
}

output "aws_s3_bucket_bucket_domain_name" {
  value = module.codepipeline.aws_s3_bucket_bucket_domain_name
}

output "aws_s3_bucket_bucket_regional_domain_name" {
  value = module.codepipeline.aws_s3_bucket_bucket_regional_domain_name
}

output "aws_s3_bucket_hosted_zone_id" {
  value = module.codepipeline.aws_s3_bucket_hosted_zone_id
}

output "aws_s3_bucket_region" {
  value = module.codepipeline.aws_s3_bucket_region
}

# IAM Role for CodeBuild
output "aws_codebuild_service_role_arn" {
  value = module.codepipeline.aws_codebuild_service_role_arn
}

# CodeBuild
output "aws_codebuild_project_arn" {
  value = module.codepipeline.aws_codebuild_project_arn
}

output "aws_codebuild_project_badge_url" {
  value = module.codepipeline.aws_codebuild_project_badge_url
}

output "aws_codebuild_project_id" {
  value = module.codepipeline.aws_codebuild_project_id
}

# IAM Role for CodePipeline
output "aws_codepipeline_service_role_arn" {
  value = module.codepipeline.aws_codepipeline_service_role_arn
}

# CodePipeline
output "aws_codepipeline_id" {
  value = module.codepipeline.aws_codepipeline_id
}

output "aws_codepipeline_arn" {
  value = module.codepipeline.aws_codepipeline_arn
}