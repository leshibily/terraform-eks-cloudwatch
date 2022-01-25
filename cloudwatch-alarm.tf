resource "aws_cloudwatch_metric_alarm" "memory_utilization_high" {
  alarm_name          = "web_server_pod_high_memory"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "pod_memory_utilization"
  namespace           = "ContainerInsights"
  period              = "10"
  statistic           = "Average"
  threshold           = "0.1"
  datapoints_to_alarm = "1"
  alarm_description   = "This metric monitors web server pod memory utilization"
  actions_enabled     = "true"
  alarm_actions       = [module.sns_topic.sns_topic_arn]
  #   ok_actions    = [module.sns_topic.sns_topic_arn]

  dimensions = {
    "ClusterName" = "${var.cluster_name}-${random_string.suffix.result}"
    "Service"     = "web-server"
    "Namespace"   = "default"

  }
  depends_on = [
    module.sns_topic,
    aws_sns_topic_subscription.email_target
  ]
}