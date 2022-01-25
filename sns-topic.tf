module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 3.0"

  name         = "container_alarm_topic"
  display_name = "Container Alarm"
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = module.sns_topic.sns_topic_arn
  protocol  = "email"
  endpoint  = var.email_id
}