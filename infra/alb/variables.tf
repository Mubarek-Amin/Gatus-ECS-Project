variable "vpc_id" {
    
  description = "vpc_id"
  type = string
}

variable "public_subnet_ids" {

  type = list(string)
  
}

variable "gatus_alb_sg_id" {
  type = string
}

variable "certificate_arn" {
  type = string
  
}