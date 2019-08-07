##########################################################
##### Variable with defaults & must provided when applying
##########################################################

##### ====================================================
##### AWS Generic #####
##### ====================================================
variable "aws_region" {
  description = "AWS region"
  default = "ap-southeast-2"
}

variable "nat_instance_type" {
  default = "t2.small"
}

variable "region" {
	default = "ap-southeast-2"
}

##### ====================================================
##### Mulesoft/Anypoint specifications  #####
##### ====================================================
variable "muleVersion" {
	default = "4.1.5"
}

variable "cloudhubEnv" {
	default = "Sandbox"
}

variable "cloudhubUrl" {
	default = "https://anypoint.mulesoft.com/accounts/login"
}

variable "cloudhubUsername" {}

variable "cloudhubPassword" {}

variable "cloudhubUsrValue" {}

variable "cloudhubPwdValue" {}


##### ====================================================
##### Codebuild Specification  #####
##### ====================================================
variable "image" {
	default = "aws/codebuild/standard:2.0"
}
variable "bucket_name" {}

variable "https_bucket_name" {}

variable "github_token" {}

variable "github_organization" {
  description = "GITHUB Organization"
  default = ""
}

variable "repo_type" {}

variable "build_timeout" {
    default = 10
}

##### ====================================================
##### AWS HA & Availability zones specifications  #####
##### ====================================================
variable "enable_ha" {
  description = "If set to true, enable setup in 2 available zones"
  type        = bool
  default 	  = false
}

variable "availability_zone1" {
	default = "ap-southeast-2a"
}

variable "availability_zone2" {
	default = "ap-southeast-2b"
}

variable "availability_zone3" {
	default = "ap-southeast-2c"
}

##### ====================================================
##### AWS KMS specifications  #####
##### ====================================================
variable "paramStoreKeyAliasName" {}
variable "paramStoreKeyGrantName" {}
variable "s3KeyAliasName" {}
variable "s3KeyGrantName" {}

##### ====================================================
##### AWS VPC network specifications  #####
##### ====================================================

variable "vpc_cidr" {
	default = "10.10.0.0/16"
}

variable "vpc_name" {
	default = "_vpc"
}

variable "public_subnet_1a_cidr" {
	default = "10.10.11.0/24"
}

variable "public_subnet_1a_name" {
	default = "public-subnet-1a"
}

variable "public_subnet_1b_cidr" {
	default = "10.10.12.0/24"
}

variable "public_subnet_1b_name" {
	default = "public-subnet-1b"
}

variable "public_subnet_1c_cidr" {
	default = "10.10.13.0/24"
}

variable "public_subnet_1c_name" {
	default = "public-subnet-1c"
}

variable "private_subnet_1a_cidr" {
	default = "10.10.21.0/24"
}

variable "private_subnet_1a_name" {
	default = "private-subnet-1a"
}

variable "private_subnet_1b_cidr" {
	default = "10.10.22.0/24"
}

variable "private_subnet_1b_name" {
	default = "private-subnet-1b"
}

variable "private_subnet_1c_cidr" {
	default = "10.10.23.0/24"
}

variable "private_subnet_1c_name" {
	default = "private-subnet-1c"
}

variable "internet_gw_name" {
	default = "cicd-internet-gateway"
}

variable "nat_gw_az1_name" {
	default = "cicd-nat-gateway_az1"
}

variable "nat_gw_az1_eip_name" {
	default = "nat-gateway-eip_az1"
}

variable "nat_gw_az2_name" {
	default = "cicd-nat-gateway_az2"
}

variable "nat_gw_az2_eip_name" {
	default = "nat-gateway-eip_az2"
}

variable "public_routetbale_name" {
	default = "public-subnet_routetable"
}

variable "private_routetbale_name_az1" {
	default = "private-subnet_routetable_az1"
}

variable "private_routetbale_name_az2" {
	default = "private-subnet_routetable_az2"
}

variable "sg-public-subnet_name" {
	default = "public-subnet_securitygroup"
}

variable "sg-private-subnet_name" {
	default = "private-subnet_securitygroup"
}

##### ====================================================
##### AWS EFS specifications  #####
##### ====================================================
variable "efs_id" {}
variable "efs-name" {}

##### ====================================================
##### AWS SNS specifications  #####
##### ====================================================
variable "sns_notificationtopic" {}

variable "sns_notificationdisplayname" {
	default = "CodeBuild Status Notification"
}

variable "snsEnv" {
	default = "Dev"
}
variable "snsPurpose" {
	default = "Notifications"
}

variable "snsCreator" {
	default = "Sri"
}

variable "sns_subscribe_display_name" {
	type        = "string"
	description = "Name shown in confirmation emails"
}
variable "sns_subscribe_email_addresses" {
	type        = "list"
	description = "Email address to send notifications to"
}

variable "sns_subscribe_protocol" {
	default     = "email-json"
	description = "SNS Protocol to use. email or email-json"
	type        = "string"
}
variable "sns_subscribe_stack_name" {
	type        = "string"
	description = "Unique Cloudformation stack name that wraps the SNS topic."
}

##### ====================================================
##### AWS CLoudwatch specifications  #####
##### ====================================================
variable "cloudwatch_eventrule" {}
variable "cloudwatch_eventrule_description" {}
variable "cloudwatch_eventtarget_id" {}

##### ====================================================
##### AWS Codebuild projects enabler  #####
##### ====================================================

variable "create_mule-email-orders" {
  description = "If set to true, creates project"
  type        = bool
  default 	  = false
}

variable "create_mule-cloudhub-auth" {
  description = "If set to true, creates project"
  type        = bool
  default 	  = false
}

variable "create_mule-temperature-api" {
  description = "If set to true, creates project"
  type        = bool
  default 	  = false
}

variable "create_mule-soap-webservice" {
  description = "If set to true, creates project"
  type        = bool
  default 	  = false
}

variable "create_mule-http-echo" {
  description = "If set to true, creates project"
  type        = bool
  default 	  = false
}