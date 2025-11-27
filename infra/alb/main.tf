resource "aws_lb" "gatus_alb" {
  name = "gatus-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.alb_sg_id]
  subnets = var.public_subnet_ids

}


resource "aws_lb_target_group" "gatus_alb_tg" {
    name = "gatus-alb-tg"
    port = 8080
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = var.vpc_id

  health_check{
    protocol = "HTTP"
    path = "/"
    matcher = "200-399"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    timeout = 5


  }
  
}


resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.gatus_alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


resource "aws_lb_listener" "HTTPS" {
  load_balancer_arn = aws_lb.gatus_alb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.certificate_arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.gatus_alb_tg.arn
  }
  
}