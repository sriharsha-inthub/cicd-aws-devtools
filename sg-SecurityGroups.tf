############################################################
##### Security Groups - For permitting from ports & ip #####
############################################################

#####=========================================================#####
##### Public subnet security group - allowing ports 	  	  #####
##### Incoming traffic from 443|80|2049 from anywhere		  ##### 
##### Incoming traffic from 22 from known IP's or IP Range	  #####
##### Outgoing traffic to anywhere							  #####
#####=========================================================#####

resource "aws_security_group" "sg-public-subnet" {

	name        			= "codebuild-sg-public-subnet-vpc-cicd"
	description 			= "Allow inbound(from) & outbound(tp) public traffic "
	vpc_id      			= "${aws_vpc.vpc.id}"
	revoke_rules_on_delete 	= "true"
	
	ingress {
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		description = "HTTPS-443 opened to all"
		cidr_blocks = ["0.0.0.0/0"]
		# Please restrict your ingress to only necessary IPs and ports.
		# Opening to 0.0.0.0/0 can lead to security vulnerabilities.
	}
	
	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		description = "HTTP-80 opened to all"
		# Please restrict your ingress to only necessary IPs and ports.
		# Opening to 0.0.0.0/0 can lead to security vulnerabilities.
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		description = "SSH-22 opened from known IPv4 range"
		cidr_blocks = ["122.166.168.201/32", "103.69.23.165/32"]
		# Restricting incoming to only necessary IPs and ports.
	}
	
	ingress {
		from_port   = 2049
		to_port     = 2049
		protocol    = "tcp"
		description = "NFS-2049 opened from all"
		cidr_blocks = ["0.0.0.0/0"]
		# Restricting incoming to only necessary IPs and ports.
	}

	egress {
		from_port       = 0
		to_port         = 0
		protocol        = "-1"
		cidr_blocks     = ["0.0.0.0/0"]
		description = "Outbound opened to all"
	}
	
	tags = {
		Name = "${var.sg-public-subnet_name}"
	}
}
#####=========================================================#####
##### Private subnet security group - allowing ports 	  	  #####
##### Incoming traffic from 22 from public subnet only!!!	  #####
##### Outgoing traffic to anywhere							  #####
#####=========================================================#####
resource "aws_security_group" "sg-private-subnet" {
	
	name        			= "codebuild-sg-private-subnet-vpc-cicd"
	description 			= "Allow inbound(from) & outbound(tp) private traffic "
	vpc_id      			= "${aws_vpc.vpc.id}"
	revoke_rules_on_delete 	= "true"
	
	ingress {
		from_port   	= 22
		to_port     	= 22
		protocol    	= "tcp"
		description 	= "SSH-22 opened from public subnet only"
		cidr_blocks     = ["0.0.0.0/0"]
		# Restricting incoming to from public subnet.
	}
	
	ingress {
		from_port   	= 2049
		to_port     	= 2049
		protocol    	= "tcp"
		description 	= "NFS-2049 opened from public subnet only"
		cidr_blocks     = ["0.0.0.0/0"]
		# Restricting incoming to from public subnet.
	}

	egress {
		from_port       = 0
		to_port         = 0
		protocol        = "-1"
		description 	= "Outbound opened to all"
		cidr_blocks     = ["0.0.0.0/0"]
	}
	
	tags = {
		Name = "${var.sg-private-subnet_name}"
	}
}