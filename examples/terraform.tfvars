# General
aws_region  = "ap-southeast-1"
aws_account = "623552185285" # AWS account where resource will be created
aws_role    = "OrganizationAccountAccessRole"

# Tagging
namespace       = "bbsdm"
bounded_context = "web"
environment     = "production"

# Github Repository
github_owner_name       = "NUS-ISS-ArchSS-Team10"
github_repo_name        = "bbsdm-web-frontend-angular"
github_repo_branch_name = "main"
github_oauth_token      = "REPLACE_ME" # Don't push me!

# S3 Bucket for Artifacts
s3_bucket_artifacts_name = "623552185285-bbsdm-web-codebuild-artifacts"

# CodeBuild
codebuild_service_role_name        = "bbsdm-web-codebuild-service-role"
codebuild_service_role_policy_name = "bbsdm-web-codebuild-service-role-policy"
codebuild_project_name             = "bbsdm-web-codebuild-project"

# CodePipeline
codepipeline_service_role_name         = "bbsdm-web-codepipeline-service-role"
codepipeline_service_role_policy_name  = "bbsdm-web-codepipeline-service-role-policy"
codepipeline_pipeline_name             = "bbsdm-web-codepipeline-pipeline"
codepipeline_deployment_s3_bucket_name = "623552185285-bbdsm-web"