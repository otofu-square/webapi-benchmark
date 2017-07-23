resource "aws_vpc" "webapi-benchmark-tf-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "webapi-benchmark-public" {
  vpc_id                  = "${aws_vpc.webapi-benchmark-tf-vpc.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}-public"
  }
}

resource "aws_internet_gateway" "webapi-benchmark-gw" {
  vpc_id = "${aws_vpc.webapi-benchmark-tf-vpc.id}"

  tags {
    Name = "${var.name}-gw"
  }
}

resource "aws_route_table" "webapi-benchmark-public-rtb" {
  vpc_id = "${aws_vpc.webapi-benchmark-tf-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.webapi-benchmark-gw.id}"
  }

  tags {
    Name = "${var.name}-public-rtb"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = "${aws_subnet.webapi-benchmark-public.id}"
  route_table_id = "${aws_route_table.webapi-benchmark-public-rtb.id}"
}

resource "aws_security_group" "app" {
  name        = "webapi-benchmark-app"
  description = "It is a security group on http of webapi-benchmark-tf-vpc"
  vpc_id      = "${aws_vpc.webapi-benchmark-tf-vpc.id}"

  tags {
    Name = "${var.name}-app"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group_rule" "web" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group_rule" "all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.app.id}"
}
