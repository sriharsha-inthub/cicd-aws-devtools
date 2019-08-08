###################################################################
##### AWS KMS - To encrypted secure parameters and s3 objects #####
###################################################################

#####=========================================================#####
##### ParameterStore - KMS Managed Key 			                  #####
#####=========================================================#####

data "aws_kms_key" "aws_paramStore_Key" {
  key_id = "alias/aws/ssm"
}

data "aws_kms_key" "aws_s3_Key" {
  key_id = "alias/aws/s3"
}

data "aws_kms_key" "aws_sns_Key" {
  key_id = "alias/aws/sns"
}

#####=========================================================#####
##### ParameterStore - KMS Customer Managed Key 			  #####
#####=========================================================#####
resource "aws_kms_key" "paramStoreKey" {
  count = "${var.create_kms_keys}" ? 1 : 0
  description 				= "KMS for encrypting & decrypting ssm parameters"
  key_usage 				= "ENCRYPT_DECRYPT"
  is_enabled 				= true
  enable_key_rotation 		= true
  deletion_window_in_days 	= 10
}

resource "aws_kms_alias" "paramStoreKeyAlias" {
  count = "${var.create_kms_keys}" ? 1 : 0
  name          = "${var.paramStoreKeyAliasName}"
  target_key_id = "${aws_kms_key.paramStoreKey[count.index].key_id}"
  depends_on = ["aws_kms_key.paramStoreKey"]
}

resource "aws_kms_grant" "paramStoreKeyGrant" {
  count = "${var.create_kms_keys}" ? 1 : 0
  name              = "${var.paramStoreKeyGrantName}"
  key_id            = "${aws_kms_key.paramStoreKey[count.index].key_id}"
  grantee_principal = "${aws_iam_role.cicd_codebuild_role.arn}"
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
  depends_on = ["aws_kms_key.paramStoreKey"]
}

#####=========================================================#####
##### S3 - KMS Customer Managed Key 						  #####
#####=========================================================#####

resource "aws_kms_key" "s3Key" {
  count = "${var.create_kms_keys}" ? 1 : 0
  description             	= "KMS for encrypting & decrypting s3 bucket objects"
  key_usage 				= "ENCRYPT_DECRYPT"
  is_enabled 				= true
  enable_key_rotation 		= true
  deletion_window_in_days 	= 10
}

resource "aws_kms_alias" "s3KeyAlias" {
  count = "${var.create_kms_keys}" ? 1 : 0
  name          = "${var.s3KeyAliasName}"
  target_key_id = "${aws_kms_key.s3Key[count.index].key_id}"
  depends_on = ["aws_kms_key.s3Key"]
}

resource "aws_kms_grant" "s3KeyGrant" {
  count = "${var.create_kms_keys}" ? 1 : 0
  name              = "${var.s3KeyGrantName}"
  key_id            = "${aws_kms_key.s3Key[count.index].key_id}"
  grantee_principal = "${aws_iam_role.cicd_codebuild_role.arn}"
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
  depends_on = ["aws_kms_key.s3Key"]
}