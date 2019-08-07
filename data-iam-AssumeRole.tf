###################################################################
##### AWS IAM Policies                                        #####
###################################################################


#####=========================================================#####
##### CodeBuild Assume Role policy                    			  #####
#####=========================================================#####
data "aws_iam_policy_document" "codebuildassumerole" {
  statement {
    sid = ""
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
    effect = "Allow"
  }
}

#####=========================================================#####
##### CodePipeline Assume Role policy                    			#####
#####=========================================================#####
data "aws_iam_policy_document" "codepipelineassumerole" {
  statement {
    sid = ""
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
    effect = "Allow"
  }
}