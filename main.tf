resource "aws_vpc" "squatch_vpc" {
	cidr_block = "10.0.0.0/16"
	enable_dns_support = true
	enable_dns_hostnames = true
	
	tags = {
		Name = "squatch_vpc"
	}
}

resource "aws_subnet" "sample_subnet" {
	vpc_id = aws_vpc.squatch_vpc.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = true
	availability_zone = "us-east-2a"

	tags = {
		Name = "sample_subnet"
	}
}

resource "aws_security_group" "sasquatch_sg" {
	vpc_id = aws_vpc.squatch_vpc.id

	ingress {
		description = "Allow SSH."
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "Allow HTTPS."
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		description = "Allow all outbound traffic."
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "sasquatch_sg"
	}
}

resource "aws_instance"	"sample_instance" {
	ami = var.ami_id
	instance_type = var.instance_type

	subnet_id = aws_subnet.sample_subnet.id
	vpc_security_group_ids = [aws_security_group.sasquatch_sg.id]

	tags = {
		Name = "sample-instance"
	}
}