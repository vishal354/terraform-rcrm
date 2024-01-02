# Create CodeDeploy application
resource "aws_codedeploy_app" "turorial_app" {
  name = "tutorial-backend-codedeploy-app"
}

# Create deployment group
resource "aws_codedeploy_deployment_group" "my_deployment_group" {
  app_name              = aws_codedeploy_app.turorial_app.name
  deployment_group_name = "tutorial-terraform-deployment-group"
  service_role_arn      = var.codedeploy_role_arn # Replace with your service role ARN

  # Blue-green deployment configuration
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.tg.name
    }
  }
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  blue_green_deployment_config {
    // Use a fixed percentage for traffic shifting
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    green_fleet_provisioning_option {
      action = "COPY_AUTO_SCALING_GROUP"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 1
    }
  }

  autoscaling_groups = [aws_autoscaling_group.tutorial_backend_asg_terraform.name]
}

output "deployment_group_name" {
  value = aws_codedeploy_deployment_group.my_deployment_group.deployment_group_name
}

# Create deployment
# resource "aws_codedeplo" "tutorial_app_terra_deployment" {
#   app_name               = aws_codedeploy_app.turorial_app.name
#   deployment_group_name  = aws_codedeploy_deployment_group.my_deployment_group.deployment_group_name
#   revision               = {
#     revision_type = "S3"
#     s3_location   = "s3://my-bucket/my-application.zip"  # Replace with your S3 bucket and object key
#   }
# }
