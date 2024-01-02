# Load Balancer
resource "aws_lb" "tutorial_lb" {
  name               = "tutorial-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.tutorial_frontend_sg.security_group_id] # Specify your security group ID
  subnets            = module.vpc.public_subnets                       # Specify your subnet IDs

  enable_deletion_protection = false
}

# Listener
resource "aws_lb_listener" "tutorial_listener" {
  load_balancer_arn = aws_lb.tutorial_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

output "load_balancer_endpoint" {
  value = aws_lb.tutorial_lb.dns_name
}