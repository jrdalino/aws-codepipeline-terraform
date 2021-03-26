# S3 Bucket for Artifacts
resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_artifacts_name
  # bucket_prefix  
  acl = "private"
  # grant
  # policy
  tags = {
    Name           = var.s3_bucket_artifacts_name
    Namespace      = var.namespace
    BoundedContext = var.bounded_context
    Environment    = var.environment
  }
  force_destroy = "true"
  # website
  # cors_rule
  versioning {
    enabled = "false"
  }
  # logging {
  #   target_bucket = "REPLACE_ME"
  #   target_prefix = "REPLACE_ME"   
  # }
  # lifecycle_rule
  # acceleration_status = Suspended
  # request_payer = BucketOwner
  # replication_configuration  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  # object_lock_configuration 
}

# S3 Bucket for Artifacts Policy
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "WhitelistedGet",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.aws_account}:role/${var.codebuild_service_role_name}",
          "arn:aws:iam::${var.aws_account}:role/${var.codepipeline_service_role_name}"
        ]
      },
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning"
      ],
      "Resource": [
        "arn:aws:s3:::${var.s3_bucket_artifacts_name}/*",
        "arn:aws:s3:::${var.s3_bucket_artifacts_name}"
      ]
    },
    {
      "Sid": "WhitelistedPut",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.aws_account}:role/${var.codebuild_service_role_name}",
          "arn:aws:iam::${var.aws_account}:role/${var.codepipeline_service_role_name}"
        ]
      },
      "Action": "s3:PutObject",
      "Resource": [
        "arn:aws:s3:::${var.s3_bucket_artifacts_name}/*",
        "arn:aws:s3:::${var.s3_bucket_artifacts_name}"
      ]
    }
  ]
}
POLICY
}

# CodeBuild Role
resource "aws_iam_role" "codebuild_service_role" {
  name = var.codebuild_service_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# CodeBuild Role Policy
resource "aws_iam_role_policy" "codebuild_service_role_policy" {
  name = var.codebuild_service_role_policy_name
  role = aws_iam_role.codebuild_service_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:ListBucket"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

# CodeBuild Project
resource "aws_codebuild_project" "this" {
  artifacts {
    type = "NO_ARTIFACTS" # Push Docker Image to ECR
  }
  # badge_enabled
  build_timeout = "5" # Adjust this if needed
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }
  description = "The CodeBuild project for ${var.github_repo_name}"
  # encryption_key
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = "true"

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }
  }
  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${var.codebuild_project_name}"
    }
  }
  name           = var.codebuild_project_name
  queued_timeout = "5"
  # secondary_artifacts
  # secondary_sources
  service_role = aws_iam_role.codebuild_service_role.arn
  source {
    type     = "GITHUB"
    location = "https://github.com/${var.github_owner_name}/${var.github_repo_name}"
  }
  # source version
  tags = {
    Name           = var.codebuild_project_name
    Namespace      = var.namespace
    BoundedContext = var.bounded_context
    Environment    = var.environment
  }
  # vpc_config
}

# CodePipeline Role
resource "aws_iam_role" "codepipeline_service_role" {
  name = var.codepipeline_service_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# CodePipeline Role Policy
resource "aws_iam_role_policy" "codepipeline_service_role_policy" {
  name = var.codepipeline_service_role_policy_name
  role = aws_iam_role.codepipeline_service_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "codecommit:GetBranch",
                "codecommit:GetCommit",
                "codecommit:UploadArchive",
                "codecommit:GetUploadArchiveStatus",
                "codecommit:CancelUploadArchive"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketVersioning"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "autoscaling:*",
                "cloudwatch:*",
                "codebuild:*",
                "codepipeline:*",
                "codedeploy:*",
                "ecs:*",
                "eks:*",
                "elasticloadbalancing:*",
                "iam:ListRoles",
                "iam:PassRole",
                "lambda:*",
                "sns:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

# CodePipeline Pipeline
resource "aws_codepipeline" "this" {
  name     = var.codepipeline_pipeline_name
  role_arn = aws_iam_role.codepipeline_service_role.arn

  artifact_store {
    location = aws_s3_bucket.this.bucket
    type     = "S3"
    # encryption_key
    # region
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.github_owner_name
        Repo       = var.github_repo_name
        Branch     = var.github_repo_branch_name
        OAuthToken = var.github_oauth_token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.this.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        Extract    = "true"
        BucketName = var.codepipeline_deployment_s3_bucket_name
      }
    }
  }

  tags = {
    Name           = var.codepipeline_pipeline_name
    Namespace      = var.namespace
    BoundedContext = var.bounded_context
    Environment    = var.environment
  }
}