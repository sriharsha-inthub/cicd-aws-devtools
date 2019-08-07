###################################################################
##### AWS Cloudwatch event rules & event targets 			  #####
###################################################################

#####=========================================================#####
##### Cloudwatch - Event to capture			 			  	  #####
#####=========================================================#####
resource "aws_cloudwatch_event_rule" "cw_event_rule" {
  name          = "${var.cloudwatch_eventrule}"
  description   = "${var.cloudwatch_eventrule_description}"
  event_pattern = "${file("data/cloudwatch_eventrule.json")}"
    
}

#####=========================================================#####
##### Cloudwatch - Event target for notification			  #####
#####=========================================================#####
resource "aws_cloudwatch_event_target" "cw_event_target" {
  target_id = "${var.cloudwatch_eventtarget_id}"
  rule = "${aws_cloudwatch_event_rule.cw_event_rule.name}"
  arn = "${aws_sns_topic.notificationtopic.arn}"
  input_path = "$.detail"
  depends_on = ["aws_sns_topic.notificationtopic"]
}
