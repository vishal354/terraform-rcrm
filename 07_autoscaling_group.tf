resource "aws_autoscaling_group" "tutorial_backend_asg_terraform" {
  name                      = "terraform-backend-asg"
  target_group_arns         = [aws_lb_target_group.tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 200
  launch_template {
    id      = aws_launch_template.tutorial_launch_template.id
    version = "$Latest" # Use the latest launch template version
  }

  min_size = 2
  max_size = 4

  vpc_zone_identifier = module.vpc.public_subnets # Replace with your subnet IDs
  # load_balancers = [  ]

  tag {
    key                 = "Name"
    value               = "my-asg-instances"
    propagate_at_launch = true
  }
}
