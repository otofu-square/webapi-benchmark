resource "aws_iam_instance_profile" "ecs_iam_role" {
  name = "ecs_iam_role"
  role = "${aws_iam_role.ecs_iam_role.name}"
}

resource "aws_iam_role" "ecs_iam_role" {
  name = "ecs_iam_role"

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

resource "aws_iam_role_policy" "ecs_iam_role" {
  name = "ecs_iam_role"
  role = "${aws_iam_role.ecs_iam_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "ecs:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
