##### Codebuild environment
aws_region="ap-southeast-2"
enable_ha=true

##### S3
bucket_name="cicdartifacts-2019"
https_bucket_name="https:\\cicdartifacts-2019"

##### GITHUB
repo_type="GITHUB"

##### KMS

paramStoreKeyAliasName="alias/cloudhubauth"
paramStoreKeyGrantName="grantcloudhubauth"

s3KeyAliasName="alias/s3"
s3KeyGrantName="grants3"
##### Cloudhub
cloudhubEnv="Sandbox"
cloudhubUrl="https://anypoint.mulesoft.com/accounts/login"
cloudhubUsername="/CodeBuild/cloudhub_username"
cloudhubPassword="/CodeBuild/cloudhub_password"

##### EFS
efs-name="cicdEFS"
efs_id="/CodeBuild/efs_id"

##### VPC, Subnets & SG
vpc_cidr="10.10.0.0/16"
vpc_name="cicd_vpc"
public_subnet_1a_cidr="10.10.11.0/24"
public_subnet_1a_name="cicd-public-subnet-1a"
public_subnet_1b_cidr="10.10.12.0/24"
public_subnet_1b_name="cicd-public-subnet-1b"
public_subnet_1c_cidr="10.10.13.0/24"
public_subnet_1c_name="cicd-public-subnet-1c"

private_subnet_1a_cidr="10.10.21.0/24"
private_subnet_1a_name="cicd-private-subnet-1a"
private_subnet_1b_cidr="10.10.22.0/24"
private_subnet_1b_name="cicd-private-subnet-1b"
private_subnet_1c_cidr="10.10.23.0/24"
private_subnet_1c_name="cicd-private-subnet-1c"

internet_gw_name="cicd-internet-gateway"

nat_gw_az1_name="cicd-nat-gateway_az1"
nat_gw_az1_eip_name="cicd-nat-gateway-eip_az1"
nat_gw_az2_name="cicd-nat-gateway_az2"
nat_gw_az2_eip_name="cicd-nat-gateway-eip_az2"

public_routetbale_name="cicd-public-subnet_routetable"

private_routetbale_name_az1="cicd-private-subnet_routetable_az1"
private_routetbale_name_az2="cicd-private-subnet_routetable_az2"

sg-public-subnet_name="cicd-public-subnet_securitygroup"
sg-private-subnet_name="cicd-private-subnet_securitygroup"

##### SNS notification topic
sns_notificationtopic="CodeBuildStatusNotificationTopic"
sns_notificationdisplayname="CodeBuild Status Notification"
snsPurpose="Notifications"
snsCreator="Sri"
snsEnv="Dev"

sns_subscribe_display_name="CodeBuildStateNotification"
sns_subscribe_email_addresses=["harshu.1982@gmail.com", "cicd.notification@gmail.com"]
sns_subscribe_protocol="email"
sns_subscribe_stack_name="SNS-Email"

cloudwatch_eventrule="CodeBuildStateNotificationRule"
cloudwatch_eventrule_description="Your Build State Notification"
cloudwatch_eventtarget_id="CodeBuildStateNotificationRule"