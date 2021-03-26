module "codepeline" {
  source = "git::https://github.com/jrdalino/aws-pipeline-terraform.git?ref=main"
  # General
  aws_region              = var.aws_region
  aws_account             = var.aws_account
  aws_role                = var.aws_role

  # Tagging
  namespace               = var.namespace
  bounded_context         = var.bounded_context
  environment             = var.environment

  # Github Repository
  github_owner_name       = var.github_owner_name
  github_repo_name        = var.github_repo_name
  github_repo_branch_name = var.github_repo_branch_name
  github_oauth_token      = var.github_oauth_token

  # S3 Bucket for Artifacts
  s3_bucket_artifacts_name = var.s3_bucket_artifacts_name
 
  # CodeBuild
  codebuild_service_role_name        = var.codebuild_service_role_name
  codebuild_service_role_policy_name = var.codebuild_service_role_policy_name
  codebuild_project_name             = var.codebuild_project_name

  # CodePipeline
  codepipeline_service_role_name         = var.codepipeline_service_role_name
  codepipeline_service_role_policy_name  = var.codepipeline_service_role_policy_name
  codepipeline_pipeline_name             = var.codepipeline_pipeline_name
  codepipeline_deployment_s3_bucket_name = var.codepipeline_deployment_s3_bucket_name
}