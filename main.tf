terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

provider "aws" {
    region = "us-east-2"
}

module "azure" {
  source   = "./azure/"

  aws_vpc_cidr = module.aws.aws_vpc_cidr
  aws_vpn_1_public_ip_1  = module.aws.aws_vpn_1_public_ip_1
  aws_vpn_1_public_ip_2  = module.aws.aws_vpn_1_public_ip_2
  aws_vpn_1_shared_key_1 = module.aws.aws_vpn_1_shared_key_1
  aws_vpn_1_shared_key_2 = module.aws.aws_vpn_1_shared_key_2
  aws_vpn_2_public_ip_1  = module.aws.aws_vpn_2_public_ip_1
  aws_vpn_2_public_ip_2  = module.aws.aws_vpn_2_public_ip_2
  aws_vpn_2_shared_key_1 = module.aws.aws_vpn_2_shared_key_1
  aws_vpn_2_shared_key_2 = module.aws.aws_vpn_2_shared_key_2

}

module "aws" {
  source = "./aws/"
}
