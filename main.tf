resource "aws_subnet" "private_subnet" {
  vpc_id = data.aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1"
  map_public_ip_on_launch = false
}