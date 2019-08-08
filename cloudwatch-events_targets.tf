###################################################################
##### AWS Cloudwatch event rules & event targets 			  #####
###################################################################

#####=========================================================#####
##### Cloudwatch - Events to capture (Build State) 			  #####
#####=========================================================#####
resource "aws_cloudwatch_event_rule" "cw_event_rule" {
  name          = "${var.cloudwatch_eventrule}"
  description   = "${var.cloudwatch_eventrule_description}"
  event_pattern = "${file("data/cloudwatch_eventrule.json")}"
    
}

#####=========================================================#####
##### Cloudwatch - (Build State)Event target for notification #####
#####=========================================================#####
resource "aws_cloudwatch_event_target" "cw_event_target" {
  target_id = "${var.cloudwatch_eventtarget_id}"
  rule = "${aws_cloudwatch_event_rule.cw_event_rule.name}"
  arn = "${aws_sns_topic.notificationtopic.arn}"
  input_path = "$.detail"
  depends_on = ["aws_sns_topic.notificationtopic"]
}

#####=========================================================#####
##### Cloudwatch - Events to capture (Build Phase) 			  #####
#####=========================================================#####
resource "aws_cloudwatch_event_rule" "cw_phase_event_rule" {
  count = 0
  name          = "${var.cloudwatch_phase_eventrule}"
  description   = "${var.cloudwatch_phase_eventrule_description}"
  event_pattern = "${file("data/cloudwatch_phase_eventrule.json")}"
    
}

#####=========================================================#####
##### Cloudwatch - (Build State)Event target for notification #####
#####=========================================================#####
resource "aws_cloudwatch_event_target" "cw_phaseevent_target" {
  count = 0
  target_id = "${var.cloudwatch_phase_eventtarget_id}"
  rule = "${aws_cloudwatch_event_rule.cw_phase_event_rule[count.index].name}"
  arn = "${aws_sns_topic.notificationtopic.arn}"
  input_path = "$.detail.additional-information.phases"
}
