variable "region" {
  type    = string
  default = "us-east-1"
}

variable "terraform_state_bucket" {
  type    = string
  default = "ex-state-bucket"
}


variable "DATABASE_URL" {
  type = string
}
