resource "aws_codepipeline" "nodejs_app_pipeline" {
  name     = "tutorial-app-backend-pipeline-terraform"
  role_arn = aws_iam_role.example.arn

  artifact_store {
    location = aws_s3_bucket.backend_art_bucket.id
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
        Owner                = "vishal354"            # Replace with your GitHub username
        Repo                 = "nodejs-express-mysql" # Replace with your GitHub repository name
        Branch               = "master"               # Replace with your branch name
        OAuthToken           = var.github_token       # Replace with your GitHub personal access token
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
        ProjectName = aws_codebuild_project.tutorial-backend-terraform.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      version         = "1"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]

      configuration = {
        ApplicationName     = aws_codedeploy_app.turorial_app.name                                      # Replace with your CodeDeploy application name
        DeploymentGroupName = aws_codedeploy_deployment_group.my_deployment_group.deployment_group_name # Replace with your CodeDeploy deployment group name
      }
    }
  }
}
