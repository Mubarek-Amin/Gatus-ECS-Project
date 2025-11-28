output "gatus_alb_target_group_arn" {
    value = aws_lb_target_group.gatus_alb_tg.arn
  
}
output "alb_dns_name" {
  value = aws_lb.gatus_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.gatus_alb.zone_id
}

output "http_listener_arn" {
  value = aws_lb_listener.HTTP.arn
}

output "https_listener_arn" {
  value = aws_lb_listener.HTTPS.arn
}

