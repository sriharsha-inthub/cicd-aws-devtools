data "aws_ami" "nat-instance" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  owners = ["amazon"]
}

#####=========================================================#####
##### NAT Instance - AZ1									  #####
#####=========================================================#####
resource "aws_instance" "nat_az1" {
  count                       = 0
  ami                         = "${data.aws_ami.nat-instance.id}"
  instance_type               = "${var.nat_instance_type}"
  source_dest_check           = false
  subnet_id                   = "${aws_subnet.public_1a.id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg-private-subnet.id}"]
  depends_on 		= ["aws_internet_gateway.internet_gw"]
  tags = {
    Name = "NAT Instance #1"
  }
}

#####=========================================================#####
##### NAT Instance - AZ2									  #####
##### count = var.enable_ha ? 1 : 0
#####=========================================================#####
resource "aws_instance" "nat_az2" {
  count                       = 0
  ami                         = "${data.aws_ami.nat-instance.id}"
  instance_type               = "${var.nat_instance_type}"
  source_dest_check           = false
  subnet_id                   = "${aws_subnet.public_1b[count.index].id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg-private-subnet.id}"]
  depends_on 		= ["aws_internet_gateway.internet_gw"]
  tags = {
    Name = "NAT Instance #2"
  }
}