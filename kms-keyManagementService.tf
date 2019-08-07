###################################################################
##### AWS KMS - To encrypted secure parameters and s3 objects #####
###################################################################


#####=========================================================#####
##### ParameterStore - KMS Customer Managed Key 			  #####
#####=========================================================#####
resource "aws_kms_key" "paramStoreKey" {
  description 				= "KMS for encrypting & decrypting ssm parameters"
  key_usage 				= "ENCRYPT_DECRYPT"
  is_enabled 				= true
  enable_key_rotation 		= true
  deletion_window_in_days 	= 10
}

resource "aws_kms_alias" "paramStoreKeyAlias" {
  name          = "${var.paramStoreKeyAliasName}"
  target_key_id = "${aws_kms_key.paramStoreKey.key_id}"
}

resource "aws_kms_grant" "paramStoreKeyGrant" {
  name              = "${var.paramStoreKeyGrantName}"
  key_id            = "${aws_kms_key.paramStoreKey.key_id}"
  grantee_principal = "${aws_iam_role.cicd_codebuild_role.arn}"
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}

#####=========================================================#####
##### S3 - KMS Customer Managed Key 						  #####
#####=========================================================#####

resource "aws_kms_key" "s3Key" {
  description             	= "KMS for encrypting & decrypting s3 bucket objects"
  key_usage 				= "ENCRYPT_DECRYPT"
  is_enabled 				= true
  enable_key_rotation 		= true
  deletion_window_in_days 	= 10
}

resource "aws_kms_alias" "s3KeyAlias" {
  name          = "${var.s3KeyAliasName}"
  target_key_id = "${aws_kms_key.s3Key.key_id}"
}

resource "aws_kms_grant" "s3KeyGrant" {
  name              = "${var.s3KeyGrantName}"
  key_id            = "${aws_kms_key.s3Key.key_id}"
  grantee_principal = "${aws_iam_role.cicd_codebuild_role.arn}"
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}