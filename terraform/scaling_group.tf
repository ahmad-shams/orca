resource "aws_launch_configuration" "as_conf" {
  name                 = "ubuntu-docker_launch_configuration"
  image_id             = "ami-00ab19fabb67a3eb0"
  instance_type        = "t2.micro"
  user_data            = file("user-data.sh")
  key_name             = "orca_scaling"
  iam_instance_profile = aws_iam_instance_profile.asg.id
  security_groups      = ["${module.security_group.security_group_id}"]
}


resource "aws_placement_group" "this" {
  name     = "orca_python_cluster"
  strategy = "cluster"
}


resource "aws_autoscaling_group" "mygroup" {
  name                      = "auto-scaling-orca-web"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete         = true
  launch_configuration = aws_launch_configuration.as_conf.name
  vpc_zone_identifier  = module.vpc.private_subnets
  target_group_arns    = module.alb.target_group_arns
  # availability_zones   = module.vpc.azs
}


# Creating the autoscaling policy of the autoscaling group
resource "aws_autoscaling_policy" "mygroup_policy" {
  name                   = "autoscalegroup_policy"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.mygroup.name
}

resource "aws_iam_instance_profile" "asg" {
  name = "asg"
  role = aws_iam_role.ec2_ecr_and_secrets_access_role.name
}
