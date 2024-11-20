variable "aws_region" {
	description = "The AWS region in which to create resources."
	default = "us-east-2"
}

variable "instance_type" {
	description = "The instance type of the EC2 instance."
	default = "t2.micro"
}

variable "ami_id" {
	description = "The AMI ID to use for the EC2 instance."
}