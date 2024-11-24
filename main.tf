resource "aws_vpc" "main" {	# aws_vpc.main will be used elsewhere. Other resource names will be used in the same manner.
	cidr_block = var.vpc_cidr
	enable_dns_support = true
	enable_dns_hostnames = true
	
	tags = {
		Name = "sasquatch-vpc"	# Use dash instead of underscore for the name
	}
}

resource "aws_subnet" "main" {
	vpc_id = aws_vpc.main.id
	cidr_block = var.subnet_cidr
	map_public_ip_on_launch = true
	availability_zone = "us-east-1a"	# Must be region + "a" "b" or "c"

	tags = {
		Name = "sasquatch-subnet"
	}
}

resource "aws_internet_gateway" "main" {
	vpc_id = aws_vpc.main.id

	tags = {
		Name = "sasquatch-igw"
	}
}

resource "aws_route_table" "main" {
	vpc_id = aws_vpc.main.id

	tags = {
		Name = "sasquatch-route-table"
	}
}

resource "aws_route_table_association" "main" {
	subnet_id = aws_subnet.main.id
	route_table_id = aws_route_table.main.id
}

resource "aws_route" "internet_access" {
	route_table_id = aws_route_table.main.id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.main.id
}

resource "aws_security_group" "main" {
	name_prefix = "sasquatch-sg-"
	description = "Allow RDP access."
	vpc_id = aws_vpc.main.id

	ingress {
		description = "Allow RDP from my IP."
		from_port = 3389
		to_port = 3389
		protocol = "tcp"
		cidr_blocks = [var.allowed_ip]
	}

	egress {
		description = "Allow all outbound traffic."
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "sasquatch-sg"
	}
}

resource "tls_private_key" "main" {
	algorithm = "RSA"
	rsa_bits = 2048		# AWS private keys are RSA at 2048 bits
}

resource "aws_key_pair"	"generated" {
	key_name = "sasquatch-key"
	public_key = tls_private_key.main.public_key_openssh
}

resource "local_file" "private_key" {
	content = tls_private_key.main.private_key_pem
	filename = "${path.module}/sasquatch-key.pem"	# This will save the pem file for the secret key into the working directory as the key_name
}

resource "aws_instance"	"windows" {
	ami = var.ami_id
	instance_type = var.instance_type
	subnet_id = aws_subnet.main.id
	vpc_security_group_ids = [aws_security_group.main.id]

	key_name = aws_key_pair.generated.key_name	
	

	tags = {
		Name = "sasquatch-windows-instance"
	}
}
