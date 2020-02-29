resource "aws_eip" "nat" {
  count = 2
  vpc   = true

  tags = {
    Name = "${var.env}-nat-1${element(var.az_names, count.index)}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = 2
  subnet_id     = aws_subnet.private_subnet[count.index].id
  allocation_id = aws_eip.nat[count.index].id
}



resource "aws_route_table" "private" {
  count  = 2
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "${var.env}-private-rt-1${element(var.az_names, count.index)}"
  }
}
