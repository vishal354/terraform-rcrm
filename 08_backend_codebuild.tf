resource "aws_codebuild_project" "tutorial-backend-terraform" {
  name          = "tutorial-backend-terraform"
  description   = "backend_tutorial_project"
  build_timeout = 5

  service_role = aws_iam_role.example.arn

  artifacts {
    type      = "S3"
    packaging = "ZIP"
    location  = aws_s3_bucket.backend_art_bucket.id
    path      = "/"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # environment_variable {
    #   name  = "SOME_KEY1"
    #   value = "SOME_VALUE1"
    # }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/vishal354/nodejs-express-mysql.git"
    git_clone_depth = 1
  }

  tags = {
    Environment = "Test"
  }
}