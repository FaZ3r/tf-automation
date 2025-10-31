terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
   cloud { 
    
    organization = "TudorNT" 

    workspaces { 
      name = "tf-aws-automation" 
    } 
  } 
}

provider "aws" {
  region = var.current_region 
}
