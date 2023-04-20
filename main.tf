
resource "aws_subnet" "private" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false
}

resource "aws_route_table" "private_table" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_table_assoctation" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_table.id
}

# resource "aws_security_group" "my_security" {
#   name = "exam_raj"
#   vpc_id = data.aws_vpc.vpc.id

# }

resource "aws_lambda_function" "lambda_function" {
  filename = "lambda_fun.zip"
  function_name = "lambda_fun"
  role = data.aws_iam_role.example.arn
  handler = "lambda_fun.lambda"
  runtime = "python3.8"
}