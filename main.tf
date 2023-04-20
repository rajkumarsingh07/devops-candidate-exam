
resource "aws_subnet" "private" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1"
  map_public_ip_on_launch = false
}

resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    nat_gateway_id = data.aws_nat_gateway.default.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "my_security" {
  name = "exam_raj"
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["10.0.4.0/24"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lambda_function" "example" {
  filename = "example.zip"
  function_name = "example"
  role = data.aws_iam_role.example.arn
  handler = "handler.example"
  runtime = "nodejs14.x"
  source_code_hash = filebase64sha256("example.zip")
}