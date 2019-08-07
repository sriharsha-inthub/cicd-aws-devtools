###################################################################################
##### AWS EFS - Creates a filesystem for use with aws instances(ec2/container #####
###################################################################################

#####=========================================================#####
##### File system							 			  	  #####
#####=========================================================#####
resource "aws_efs_file_system" "cicd_EFS" {
	creation_token = "my-product"
	encrypted = "false"
	performance_mode = "generalPurpose"
	throughput_mode = "bursting"
	
	tags = {
		Name = "${var.efs-name}"
	}
}


#####=========================================================#####
##### File system mount targets				 			  	  #####
#####=========================================================#####

resource "aws_efs_mount_target" "cicd_EFS_MountTarget_private_subnet_1a" {
	file_system_id = "${aws_efs_file_system.cicd_EFS.id}"
	subnet_id      = "${aws_subnet.private_1a.id}"
	ip_address = ""
	security_groups = ["${aws_security_group.sg-private-subnet.id}"]
	depends_on = ["aws_efs_file_system.cicd_EFS"]
}
resource "aws_efs_mount_target" "cicd_EFS_MountTarget_private_subnet_1b" {
	count = "${var.enable_ha}" ? 1 : 0
	file_system_id = "${aws_efs_file_system.cicd_EFS.id}"
	subnet_id      = "${aws_subnet.private_1b[count.index].id}"
	ip_address = ""
	security_groups = ["${aws_security_group.sg-private-subnet.id}"]
	depends_on = ["aws_efs_file_system.cicd_EFS"]
}