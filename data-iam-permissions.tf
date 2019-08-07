###################################################################
##### AWS IAM Policy permissions                              #####
###################################################################


#####=========================================================#####
##### CodeBuild Permissions                     			  #####
#####=========================================================#####
data "aws_iam_policy_document" "codebuildpermissions1" {
  statement {
      sid = ""
      actions = [
        "iam:PassRole",
        "sns:*",
        "s3:*",
        "ec2:*",
        "ssm:*",
        "kms:*",
        "events:*",
        "cloudwatch:*",
        "logs:*",
        "ecr:*",
        "ecs:*",
      ]
      resources = ["*"]
      effect = "Allow"
  }
}

data "aws_iam_policy_document" "codebuildpermissions2" {
  statement {
      sid = ""
      actions = [
        "ec2:DescribeInstances",
        "ec2:CreateNetworkInterface",
        "ec2:AttachNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
      ]
      resources = ["*"]
      effect = "Allow"
  }
}

#####=========================================================#####
##### CodePipeline Permissions                     			  #####
#####=========================================================#####
data "aws_iam_policy_document" "codepipelinepermissions" {
  statement {
    sid = ""
    actions = [
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "events:*",
      "s3:*",
      "sns:*",
      "ssm:*",
      "kms:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*",
      "ecr:*",
      "iam:PassRole",
      "logs:*",
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}