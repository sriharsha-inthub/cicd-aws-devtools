############################################################
##### Routes - FOr VPC & Its Sub networks 			   #####
############################################################

#####=========================================================#####
##### Public route table - Route to Internet gateway		  #####
#####=========================================================#####
resource "aws_route_table" "public_routetable" {
	vpc_id = "${aws_vpc.vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.internet_gw.id}"
	}
	tags = {
		Name = "${var.public_routetbale_name}"
	}
}

#####=========================================================#####
##### Private route table - Route to NAT gateway			  #####
#####=========================================================#####
resource "aws_route_table" "private_routetable_az1" {
	vpc_id = "${aws_vpc.vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id  = "${aws_nat_gateway.nat_gw_az1.id}"
	}
	tags = {
		Name = "${var.private_routetbale_name_az1}"
	}
}

resource "aws_route_table" "private_routetable_az2" {
	count = "${var.enable_ha}" ? 1 : 0
	vpc_id = "${aws_vpc.vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id  = "${aws_nat_gateway.nat_gw_az2[count.index].id}"
	}
	tags = {
		Name = "${var.private_routetbale_name_az2}"
	}
}

#####=========================================================#####
##### PUBLIC Subnet assiosation with public route table   	  #####
#####=========================================================#####
resource "aws_route_table_association" "route_public_1a" {
	subnet_id = "${aws_subnet.public_1a.id}"
	route_table_id = "${aws_route_table.public_routetable.id}"
}
resource "aws_route_table_association" "main-public-1b" {
	count = "${var.enable_ha}" ? 1 : 0
	subnet_id = "${aws_subnet.public_1b[count.index].id}"
	route_table_id = "${aws_route_table.public_routetable.id}"
}

#####=========================================================#####
##### PRIVATE Subnet assiosation with private route table     #####
#####=========================================================#####
resource "aws_route_table_association" "route_priavte_1a" {
	subnet_id = "${aws_subnet.private_1a.id}"
	route_table_id = "${aws_route_table.private_routetable_az1.id}"
}
resource "aws_route_table_association" "route_priavte_1b" {
	count = "${var.enable_ha}" ? 1 : 0
	subnet_id = "${aws_subnet.private_1b[count.index].id}"
	route_table_id = "${aws_route_table.private_routetable_az2[count.index].id}"
}