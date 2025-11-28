terraform{
    required_providers{

        aws = {
            source = "hashicorp/aws"
            version = "6.21.0"
        }

    }
    backend "s3" {
  bucket = "tf-state-gatus"
  key = "terraform.tfstate"
  region = "eu-north-1"
  encrypt = true
  dynamodb_table = "state-lock"

  }

}

provider "aws"{
 region = "eu-north-1"
}

resource "aws_dynamodb_table" "tf_lock" {
    name = "state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "production"
  }
  
}