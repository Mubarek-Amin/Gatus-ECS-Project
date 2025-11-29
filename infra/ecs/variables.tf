variable "private_subnet_ids" {
    type = list(string)
}

variable "target_group_arn" {
    description = "target group arn for gatus-alb"
    type = string
  
}

variable "ecs_sg_id"{
    description = "security group for alb"
    type = string
}

variable "gatus_image" {
  type = string
}

variable "image_tag" {
    default = "latest"
  
}

variable "region" {
    default = "eu-north-1"
  
}
variable "execution_role_arn" {
    type = string
  
}