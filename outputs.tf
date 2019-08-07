#####=========================================================#####

#####	S3	#####
output "s3-id" {
	value       = "${aws_s3_bucket.bucket.id}"
}

output "s3-bucket_domain_name" {
	value       = "${aws_s3_bucket.bucket.bucket_domain_name}"
}

output "s3-bucket_regional_domain_name" {
	value       = "${aws_s3_bucket.bucket.bucket_regional_domain_name}"
}

#####	EFS	 #####
output "efs-id" {

	value       = "${aws_efs_file_system.cicd_EFS.id}"
}

output "efs-dns_name" {
	value       = "${aws_efs_file_system.cicd_EFS.dns_name}"
}

#####	EIP-NAT	 #####
### output "eip-nat-id" {
### 	value       = "${aws_eip.nat_eip.id}"
### }
### 
### output "eip-nat-public_ip" {
### 	value       = "${aws_eip.nat_eip.public_ip}"
### }
### 
### output "eip-nat-public_dns" {
### 	value       = "${aws_eip.nat_eip.public_dns}"
### }
