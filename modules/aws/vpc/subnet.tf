resource "aws_subnet" "public_subnet" {
  count             = 2
  availability_zone = "ap-northeast-1${element(var.az_names, count.index)}"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)

  tags = {
    Name = "${var.env}-public-1${element(var.az_names, count.index)}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 2
  availability_zone = "ap-northeast-1${element(var.az_names, count.index)}"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index + 2)

  tags = {
    Name = "${var.env}-private-1${element(var.az_names, count.index)}"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
