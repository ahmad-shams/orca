resource "aws_launch_configuration" "as_conf" {
  name          = "ubuntu-docker"
  image_id      = "ami-0a90a1644a34a4a5e"
  instance_type = "t2.micro"
  user_data     = file("user-data.sh")
  key_name      = "orca_scaling"
  iam_instance_profile = "${aws_iam_instance_profile.asg.id}"
  security_groups = [ "${module.security_group.security_group_id}" ]
}


resource "aws_placement_group" "this" {
  name     = "orca_python_cluster"
  strategy = "cluster"
}



resource "aws_autoscaling_group" "this" {
  name                      = "orca-python-autoscaling-group"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  #   placement_group           = aws_placement_group.this.id
  launch_configuration = aws_launch_configuration.as_conf.name
  vpc_zone_identifier  = module.vpc.private_subnets

  # initial_lifecycle_hook {
  #   name                 = "foobar"
  #   default_result       = "CONTINUE"
  #   heartbeat_timeout    = 2000
  #   lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"



  #   notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
  #   role_arn = aws_iam_role.ec2_ecr_and_secrets_access_role.arn

  # }
}


resource "aws_iam_instance_profile" "asg" {
  name = "asg"
  role = aws_iam_role.ec2_ecr_and_secrets_access_role.name
}
