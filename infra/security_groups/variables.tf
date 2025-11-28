variable "vpc_id" {
  type = string
}
variable "vpc_cidr_block"{
  type = string
}
variable "cidr_blocks_all" {
  default = ["0.0.0.0/0"]
  
}
variable "gatus_port" {
  default = 8080
  
}