provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_ecs_cluster" "webapi-benchmark-cluster" {
  name = "webapi-benchmark-cluster"
}

resource "aws_instance" "webapi-benchmark-ecs" {
  count                       = 2
  instance_type               = "t2.micro"
  ami                         = "ami-e4657283"
  subnet_id                   = "${aws_subnet.webapi-benchmark-public.id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.app.id}"]
  iam_instance_profile        = "ecs_iam_role"
  key_name                    = "otofu-square-ff-sandbox"
  user_data                   = "${file("user_data/userdata.sh")}"

  tags = {
    Name = "${var.name}-cluster-instance-${count.index}"
  }
}
