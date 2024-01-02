resource "aws_lb_target_group" "tg" {
  name        = "tutorial-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"    # Specify the health check path
    port                = 8080   # Specify the health check port
    protocol            = "HTTP" # Specify the health check protocol (HTTP/HTTPS)
    unhealthy_threshold = 2
    healthy_threshold   = 2
    interval            = 30
    timeout             = 5
  }
}

# resource "aws_lb_target_group_attachment" "attached_instance1" {
#   target_group_arn = aws_lb_target_group.tg.arn
#   target_id        = module.ec2_instance1.id
# }

# resource "aws_lb_target_group_attachment" "attached_instance2" {
#   target_group_arn = aws_lb_target_group.tg.arn
#   target_id        = module.ec2_instance2.id
# }