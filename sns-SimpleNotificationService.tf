##########################################################################
##### AWS SNS - Creates a topic to publish events to from cloudwatch #####
##########################################################################

#####=========================================================#####
##### SNS Topic with delivery policy		 			  	  #####
#####=========================================================#####

resource "aws_sns_topic" "notificationtopic" {
  name = "${var.sns_notificationtopic}"
  display_name = "${var.sns_notificationdisplayname}"
  delivery_policy = <<EOF
{
  "http": {
	"defaultHealthyRetryPolicy": {
	  "minDelayTarget": 20,
	  "maxDelayTarget": 20,
	  "numRetries": 3,
	  "numMaxDelayRetries": 0,
	  "numNoDelayRetries": 0,
	  "numMinDelayRetries": 0,
	  "backoffFunction": "linear"
	},
	"disableSubscriptionOverrides": false,
	"defaultThrottlePolicy": {
	  "maxReceivesPerSecond": 1
	}
  }
}
EOF
  tags = {
	Environment = "${var.snsEnv}",
	Purpose = "${var.snsPurpose}",
	Creator = "${var.snsCreator}"
  }
}