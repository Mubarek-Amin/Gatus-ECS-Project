variable "terraform_state_bucket" {
  default = "tf-state-gatus"

}
variable "region" {
  default = "eu-north-1"

}

variable "dynamodb_table_name" {
  default = "state-lock"
}
variable "account_id" {
  default = "304035489951"
}
variable "terraform_user_name" {
  default = "amin-mub"
}