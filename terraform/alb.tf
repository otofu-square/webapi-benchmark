resource "aws_alb" "alb" {
  subnets = ["${aws_subnet.webapi-benchmark-public.id}"]

  tags = {
    Name = "${var.name}-alb"
  }
}

resource "aws_alb_target_group" "alb" {
  name     = "${var.name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.webapi-benchmark-tf-vpc.id}"
}

resource "aws_alb_target_group_attachment" "alb" {
  count            = 2
  target_group_arn = "${aws_alb_target_group.alb.arn}"
  target_id        = "${element(aws_instance.webapi-benchmark-ecs.*.id, count.index)}"
}

resource "aws_alb_listener" "alb" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb.arn}"
    type             = "forward"
  }
}
