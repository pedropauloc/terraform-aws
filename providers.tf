terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  shared_credentials_file = "/Users/pedrocarv/Documents/DevTools/AWS-Teste-Galp/credentials"
  profile = "default"

}

provider "external" {}
