resource "aws_security_group" "alb_sg" {
  name = "alb"
  vpc_id = var.vpc_id

 

}
