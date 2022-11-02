resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet[0].id

  depends_on = [
    aws_internet_gateway.internet-gw
  ]

  tags = {
    "Name"     = "Nat-gateway"
    "Project"  = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

    tags = {
    "Name"     = "private_route_table"
    "Project"  = "${var.project}"
    "CreateBy" = "${var.CreateBy}"
  }
}

resource "aws_route_table_association" "private-rta" {
  count = var.public_sn_count
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-rt.id
}