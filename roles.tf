resource "aws_iam_role" "docker_role" {
  name = "docker_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "docker_role_policy" {
  name = "docker_role_policy"
  policy = file("dockerhost-role")
  role = aws_iam_role.docker_role.name
}

resource "aws_iam_instance_profile" "docker_profile" {
  name = "docker_profile"
  role = "${aws_iam_role.docker_role.name}"
}