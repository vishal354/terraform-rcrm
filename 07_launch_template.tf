resource "aws_launch_template" "tutorial_launch_template" {
  name_prefix   = "tutorial-backend-template"
  image_id      = data.aws_ami.ubuntu.id # Replace with your desired AMI
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [module.tutorial_backend_sg.security_group_id]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8 # 8 GiB root volume
      volume_type = "gp2"
    }
  }

  iam_instance_profile {
    arn = "arn:aws:iam::547204702969:instance-profile/ec2_backend_role"
  }

  # vpc_security_group_ids = [module.tutorial_backend_sg.security_group_id]
  key_name = var.key_name

  user_data = filebase64("/userdata.sh")
}
