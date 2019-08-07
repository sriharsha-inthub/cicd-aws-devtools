############################################################
##### SSM - to store secure parameters				   #####					
############################################################

#####=========================================================#####
##### Secure Parameter - Cloudhub username					  #####
#####=========================================================#####
resource "aws_ssm_parameter" "cloudhubusr" {
  name        = "/CodeBuild/cloudhub_username"
  description = "cloudhub username"
  type        = "SecureString"
  value       = "${var.cloudhubUsrValue}"
  tier 		  = "Standard"
  key_id	  = "${aws_kms_key.paramStoreKey.key_id}"
  overwrite   = true
  tags = {
    environment = "${var.cloudhubEnv}"
  }
}

#####=========================================================#####
##### Secure Parameter - Cloudhub password					  #####
#####=========================================================#####
resource "aws_ssm_parameter" "cloudhubpwd" {
  name        = "/CodeBuild/cloudhub_password"
  description = "cloudhub password"
  type        = "SecureString"
  value       = "${var.cloudhubPwdValue}"
  tier 		  = "Standard"
  key_id	  = "${aws_kms_key.paramStoreKey.key_id}"
  overwrite   = true
  tags = {
    environment = "${var.cloudhubEnv}"
  }
}

#####=========================================================#####
##### Secure Parameter - NFS ID								  #####
#####=========================================================#####
resource "aws_ssm_parameter" "efs_id" {
  name        = "/CodeBuild/efs_id"
  description = "elastic filesystem id"
  type        = "SecureString"
  value       = "${aws_efs_file_system.cicd_EFS.id}"
  tier 		  = "Standard"
  key_id	  = "${aws_kms_key.paramStoreKey.key_id}"
  overwrite   = true
  tags = {
    environment = "${var.efs_id}"
  }
  depends_on = ["aws_efs_file_system.cicd_EFS"]
}