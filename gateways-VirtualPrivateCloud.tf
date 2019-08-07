############################################################
##### Gateways - For VPC & Its Sub networks 		   #####
############################################################

#####=========================================================#####
##### Internet gateway										  #####
#####=========================================================#####

resource "aws_internet_gateway" "internet_gw" {
	vpc_id = "${aws_vpc.vpc.id}"

	tags = {
		Name = "${var.internet_gw_name}"
	}
	
	depends_on = ["aws_vpc.vpc"]
}


#####=========================================================#####
##### NAT gateway - AZ1										  #####
#####=========================================================#####

resource "aws_nat_gateway" "nat_gw_az1" {
	allocation_id 	= "${aws_eip.nat_eip_az1.id}"
	subnet_id 		= "${aws_subnet.public_1a.id}"
	depends_on 		= ["aws_internet_gateway.internet_gw"]
	tags = {
		Name = "${var.nat_gw_az1_name}"
	}
}

#####============================================================#####
##### NAT gateway elastic IP - pre-requisite to NAT gateway AZ1  #####
#####============================================================#####
resource "aws_eip" "nat_eip_az1" {
	vpc = true
	depends_on = ["aws_internet_gateway.internet_gw"]
}

#####=========================================================#####
##### NAT gateway - AZ2										  #####
#####=========================================================#####

resource "aws_nat_gateway" "nat_gw_az2" {
	count = "${var.enable_ha}" ? 1 : 0
	allocation_id 	= "${aws_eip.nat_eip_az2[count.index].id}"
	subnet_id 		= "${aws_subnet.public_1b[count.index].id}"
	depends_on 		= ["aws_internet_gateway.internet_gw"]
	tags = {
		Name = "${var.nat_gw_az2_name}"
	}
}

#####============================================================#####
##### NAT gateway elastic IP - pre-requisite to NAT gateway AZ2  #####
#####============================================================#####
resource "aws_eip" "nat_eip_az2" {
	count = "${var.enable_ha}" ? 1 : 0
	vpc = true
	depends_on = ["aws_internet_gateway.internet_gw"]
}