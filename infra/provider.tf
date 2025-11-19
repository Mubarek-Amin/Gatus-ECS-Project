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

  }

}

provider "aws"{
 region = "eu-north-1"
}
