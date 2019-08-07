############################################################
##### IAM - Roles and Policies						   #####					
############################################################

##############################################
############ Codebuild assume role ###########
##############################################
resource "aws_iam_role" "cicd_codebuild_role" {
  name 					= "cicd_codebuild_role"
  assume_role_policy 	= "${data.aws_iam_policy_document.codebuildassumerole.json}"
}

########## Codebuild Permissions1 ##########
resource "aws_iam_policy" "cicd_codebuild_permissions_policy1" {
  name        = "cicd_codebuild_permissions_policy1"
  path        = "/cicdpolicy/"
  description = "Policy with required permission used in trust relationship with CodeBuild"
  policy 	  = "${data.aws_iam_policy_document.codebuildpermissions1.json}"
}

########## Codebuild Permissions2 ##########
resource "aws_iam_policy" "cicd_codebuild_permissions_policy2" {
  name        = "cicd_codebuild_permissions_policy2"
  path        = "/cicdpolicy/"
  description = "Policy with ec2 network interface permissions in trust relationship with CodeBuild"
  policy 	  = "${data.aws_iam_policy_document.codebuildpermissions2.json}"
}

########## Codebuild Policy(Permissions1) attachment to role ##########
resource "aws_iam_policy_attachment" "codebuild_role_policy_attachment1" {
  name       = "codebuild_role_policy_attachment1"
  policy_arn = "${aws_iam_policy.cicd_codebuild_permissions_policy1.arn}"
  roles      = ["${aws_iam_role.cicd_codebuild_role.id}"]
}

########## Codebuild Policy(Permissions2) attachment to role ##########
resource "aws_iam_policy_attachment" "codebuild_role_policy_attachment2" {
  name       = "codebuild_role_policy_attachment2"
  policy_arn = "${aws_iam_policy.cicd_codebuild_permissions_policy2.arn}"
  roles      = ["${aws_iam_role.cicd_codebuild_role.id}"]
}



##############################################
########## Codepipeline assume role ##########
##############################################

resource "aws_iam_role" "cicd_codepipeline_role" {
  name 					= "cicd_codepipeline_role"
  assume_role_policy 	= "${data.aws_iam_policy_document.codepipelineassumerole.json}"
}

########## Codepipeline Permissions ##########
resource "aws_iam_policy" "cicd_codepipeline_permissions_policy" {
  name        = "cicd_codepipeline_permissions_policy"
  path        = "/cicdpolicy/"
  description = "Policy with required permission used in trust relationship with CodePipeline"
  policy 	  = "${data.aws_iam_policy_document.codepipelinepermissions.json}"
}

########## Codepipeline Policy(Permissions) attachment to role ##########
resource "aws_iam_policy_attachment" "codepipeline_role_policy_attachment" {
  name       = "codepipeline_role_policy_attachment"
  policy_arn = "${aws_iam_policy.cicd_codepipeline_permissions_policy.arn}"
  roles      = ["${aws_iam_role.cicd_codepipeline_role.id}"]
}
