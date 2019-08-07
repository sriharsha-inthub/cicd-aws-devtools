############################################################
##### VPC - Virtual Provate cloud					   #####					
############################################################

#####=========================================================#####
##### VPC with DNS support & hostname resolution			  #####
#####=========================================================#####
resource "aws_vpc" "vpc" {
	cidr_block       					= "${var.vpc_cidr}"
	instance_tenancy 					= "default"
	enable_dns_support 					= "true"
	enable_dns_hostnames 				= "true"
	assign_generated_ipv6_cidr_block 	= "false"
	tags = {
		Name = "${var.vpc_name}"
	}
}



############### 				Subnets 			 ##############
#####=========================================================#####
##### VPC Public subnets in availability zone-1				  #####
#####=========================================================#####
resource "aws_subnet" "public_1a" {
	vpc_id     						= "${aws_vpc.vpc.id}"
	cidr_block 						= "${var.public_subnet_1a_cidr}"
	map_public_ip_on_launch 		= "true"
	availability_zone 				= "${var.availability_zone1}"
	assign_ipv6_address_on_creation = "false"

	tags = {
		Name = "${var.public_subnet_1a_name}"
	}
	depends_on = ["aws_internet_gateway.internet_gw"]
}

#####=========================================================#####
##### VPC Public subnets in availability zone-2				  #####
#####=========================================================#####
resource "aws_subnet" "public_1b" {
	count = "${var.enable_ha}" ? 1 : 0
	vpc_id     						= "${aws_vpc.vpc.id}"
	cidr_block 						= "${var.public_subnet_1b_cidr}"
	map_public_ip_on_launch 		= "true"
	availability_zone 				= "${var.availability_zone2}"
	assign_ipv6_address_on_creation = "false"

	tags = {
		Name = "${var.public_subnet_1b_name}"
	}
	depends_on = ["aws_internet_gateway.internet_gw"]
}

#####=========================================================#####
##### VPC Private subnets in availability zone-1			  #####
#####=========================================================#####
resource "aws_subnet" "private_1a" {
	vpc_id     						= "${aws_vpc.vpc.id}"
	cidr_block 						= "${var.private_subnet_1a_cidr}"
	map_public_ip_on_launch 		= "false"
	availability_zone 				= "${var.availability_zone1}"
	assign_ipv6_address_on_creation = "false"

	tags = {
		Name = "${var.private_subnet_1a_name}"
	}
}

#####=========================================================#####
##### VPC Private subnets in availability zone-2			  #####
#####=========================================================#####
resource "aws_subnet" "private_1b" {
	count = "${var.enable_ha}" ? 1 : 0
	vpc_id     						= "${aws_vpc.vpc.id}"
	cidr_block 						= "${var.private_subnet_1b_cidr}"
	map_public_ip_on_launch 		= "false"
	availability_zone 				= "${var.availability_zone2}"
	assign_ipv6_address_on_creation	= "false"

	tags = {
		Name = "${var.private_subnet_1b_name}"
	}
}
