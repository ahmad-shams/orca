resource "aws_iam_role" "ec2_ecr_and_secrets_access_role" {
  name               = "ec2_ecr_and_secrets_access_role"
  assume_role_policy = "${file("policy_assume_role.json")}"
}


resource "aws_iam_policy" "image_n_secrets" {
  policy = "${file("policy_ecr_and_secrets.json")}"
}

resource "aws_iam_policy_attachment" "this" {
  name       = "attach_image_n_secrets"
  roles      = ["${aws_iam_role.ec2_ecr_and_secrets_access_role.name}"]
  policy_arn = "${aws_iam_policy.image_n_secrets.arn}"
}




