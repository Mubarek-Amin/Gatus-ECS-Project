resource "aws_security_group" "alb_sg" {
  name = "alb"
  vpc_id = var.vpc_id

 

}
resource "aws_security_group_rule" "allow_all_http_in_alb" {
  type = "ingress"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks =[var.cidr_blocks_all] 
  from_port = 80
  to_port = 80
  protocol = "tcp"
  
}
resource "aws_security_group_rule" "allow_all_https_in_alb" {
  type = "ingress"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks = [var.cidr_blocks_all]
  from_port = 443
  to_port = 443
  protocol = "tcp"
  
}
resource "aws_security_group_rule" "alb_out_to_ecs" {
  type = "egress"
  source_security_group_id = aws_security_group.ecs_sg.id
  security_group_id = aws_security_group.alb_sg.id
  from_port = var.gatus_port
  to_port = var.gatus_port
  protocol = "tcp"
  
}
resource "aws_security_group" "ecs_sg" {
  name = "ecs"
  vpc_id = var.vpc_id

}
resource "aws_security_group_rule" "ecs_in_from_alb" {
  type = "ingress"
  security_group_id = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.alb_sg
  from_port = var.gatus_port
  to_port = var.gatus_port
  protocol = "tcp"

}
resource "aws_security_group_rule" "allow_all_local" {
  type = "ingress"
  security_group_id = aws_security_group.ecs_sg.id
  cidr_blocks = [var.vpc_cidr_block]
  from_port = 0
  to_port = 0
  protocol = -1

}
resource "aws_security_group_rule" "all_ecs_out" {
  type = "egress"
  security_group_id = aws_security_group.ecs_sg.id
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [var.cidr_blocks_all]

}

