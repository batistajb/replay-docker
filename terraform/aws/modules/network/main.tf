resource "aws_vpc" "replay_app_private_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
      tomap({"Name" = "replay_app_private_vpc"}),
      tomap({"kubernetes.io/cluster/${local.cluster_name}" = "shared"}),
      var.tags
  )
}

resource "aws_internet_gateway" "replay_app_internet_gateway" {
  vpc_id = aws_vpc.replay_app_private_vpc.id

  tags = merge(
    tomap({"Name" = "replay_app_internet_gateway"}),
    var.tags
  )
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "replay-app-eks-subnet" {
  count = 3
  vpc_id                  = aws_vpc.replay_app_private_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.replay_app_private_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    tomap({"Name" = "replay-app-eks-subnet"}),
    tomap({"kubernetes.io/cluster/${local.cluster_name}" = "shared"}),
    var.tags
  )
}

resource "aws_route_table" "replay_app_route_table" {
  vpc_id = aws_vpc.replay_app_private_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.replay_app_internet_gateway.id
  }

  tags = merge(
      tomap({"Name" = "replay-app-route-table"}),
      var.tags
  )
}

resource "aws_route_table_association" "replay_app_route_table_associacion" {
  subnet_id      = aws_subnet.replay-app-eks-subnet.*.id[count.index]
  route_table_id = aws_route_table.replay_app_route_table.id
  count          = 3
}