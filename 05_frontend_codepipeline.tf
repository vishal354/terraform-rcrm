resource "aws_codepipeline" "react_app_pipeline" {
  name     = "tutorial-app-pipeline-terraform"
  role_arn = aws_iam_role.example.arn

  artifact_store {
    location = aws_s3_bucket.art_bucket.id
    type     = "S3"
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
        Owner                = "vishal354"          # Replace with your GitHub username
        Repo                 = "react-crud-web-api" # Replace with your GitHub repository name
        Branch               = "master"             # Replace with your branch name
        OAuthToken           = var.github_token     # Replace with your GitHub personal access token
        PollForSourceChanges = "false"
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
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.tutorial-project.name
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
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        BucketName = aws_s3_bucket.my_bucket.id
        Extract    = "true"
      }
    }
  }
}


# IAM roles for the codepipeline
# resource "aws_iam_role" "codepipeline_role" {
#   name               = "tutorial-terraform-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "aws_iam_policy_document" "codepipeline_policy" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "s3:GetBucketVersioning",
#       "s3:PutObjectAcl",
#       "s3:PutObject",
#     ]

#     resources = [
#       aws_s3_bucket.my_bucket.arn,
#       "${aws_s3_bucket.my_bucket.arn}/*"
#     ]
#   }


#   statement {
#     effect = "Allow"

#     actions = [
#       "codebuild:BatchGetBuilds",
#       "codebuild:StartBuild",
#     ]

#     resources = ["*"]
#   }
# }

# resource "aws_iam_role_policy" "codepipeline_policy" {
#   name   = "codepipeline_policy_terraform"
#   role   = aws_iam_role.codepipeline_role.id
#   policy = data.aws_iam_policy_document.codepipeline_policy.json
# }

# data "aws_kms_alias" "s3kmskey" {
#   name = "alias/myKmsKey"
# }
