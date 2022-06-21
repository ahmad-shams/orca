provider "aws" {
  region = var.region
}

resource "aws_kms_key" "terraform-bucket-key" {
 description             = "This key is used to encrypt bucket objects"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "key-alias" {
 name          = "alias/terraform-bucket-key"
 target_key_id = aws_kms_key.terraform-bucket-key.key_id
}

terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63"
    }
  }

  backend "s3" {
    bucket         = "ex-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/terraform-bucket-key"
    # dynamodb_table = "terraform-lock"
  }
}