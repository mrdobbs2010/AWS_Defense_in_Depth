terraform {				# Check Terraform and AWS for most updated versions to use here.
	required_version = ">= 0.12"

	required_providers {
		aws = {
		source = "hashicorp/aws"
		version = "~> 3.0"
		}
	}
}