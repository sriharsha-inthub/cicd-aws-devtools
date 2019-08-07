
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
### "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
