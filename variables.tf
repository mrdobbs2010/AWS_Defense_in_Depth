variable "aws_region" {
	description = "The AWS region in which to create resources."
	default = "us-east-1"					# Choose ami in AWS first, then use the region in which it is found
}

variable "instance_type" {
	description = "The instance type of the EC2 instance."	# t2.micro is included in free tier on AWS, t3.micro is offered free in regions where t2.micro is not available
	default = "t2.micro"
}

variable "key_name" {
	description = "The key pair to connect via RDP."	# Key pair will be generated and applied in main.tf
	default = "sasquatch-key"
}

variable "ami_id" {
	description = "The AMI ID to use for the EC2 instance."
	default = "ami-0001f2e4067c93dd1"			# Find a suitable ami on AWS EC2 Console > 	AMIs...dropdown menu - "public", search "windows", search "base"
}								# Nearly all Windows amis have a GUI, but all "base" ones do

variable "vpc_cidr" {
	default = "10.0.0.0/16"										
}

variable "subnet_cidr" {
	default = "10.0.1.0/24"					# Must be different than vpc_cidr
}

variable "allowed_ip" {
	description = "My IP to connect via RDP."
	default = "0.0.0.0/0"					# change to your IPv4 (**recommended**) (find it at whatsmyip.org) or use 0.0.0.0/0.
}
