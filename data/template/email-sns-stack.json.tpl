{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Resources" : {
    "CodeBuildStatusNotificationTopic": {
      "Type" : "AWS::SNS::Topic",
      "Properties" : {
        "DisplayName" : "${display_name}",
        "Subscription": [
          {
           "Endpoint" : "${email_address}",
           "Protocol" : "${protocol}"
          }
        ]
      }
    }
  },

  "Outputs" : {
    "ARN" : {
      "Description" : "CodeBuildStatusNotificationTopic-ARN",
      "Value" : { "Ref" : "EmailSNSTopic" }
    }
  }
}