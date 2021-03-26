# General
variable "aws_region" {
  type        = string
  description = "Used AWS Region."
}

variable "aws_account" {
  type        = string
  description = "Used AWS Account."
}

variable "aws_role" {
  type        = string
  description = "Used AWS Role."
}

# Tagging
variable "namespace" {
  type        = string
  description = "Namespace."
}

variable "bounded_context" {
  type        = string
  description = "Bounded Context."
}

variable "environment" {
  type        = string
  description = "Environment."
}

# Github Repository
variable "github_owner_name" {
  type        = string
  description = "Github Owner name."
}

variable "github_repo_name" {
  type        = string
  description = "Github Repository name."
}

variable "github_repo_branch_name" {
  type        = string
  description = "Github Repository branch name."
}

variable "github_oauth_token" {
  type        = string
  description = "Github OAuth token."
}

# S3 Bucket for Artifacts
variable "s3_bucket_artifacts_name" {
  type        = string
  description = "S3 Bucket for Artifacts name."
}

# CodeBuild
variable "codebuild_service_role_name" {
  type        = string
  description = "CodeBuild Service Role name."
}

variable "codebuild_service_role_policy_name" {
  type        = string
  description = "CodeBuild Service Role Policy name."
}

variable "codebuild_project_name" {
  type        = string
  description = "Codebuild Project name."
}

# CodePipeline
variable "codepipeline_service_role_name" {
  type        = string
  description = "CodePipeline Service Role name."
}

variable "codepipeline_service_role_policy_name" {
  type        = string
  description = "CodePipeline Service Role Policy name."
}

variable "codepipeline_pipeline_name" {
  type        = string
  description = "Codepipeline Pipeline name."
}

variable "codepipeline_deployment_s3_bucket_name" {
  type        = string
  description = "Codepipeline Deployment S3 bucket name."
}