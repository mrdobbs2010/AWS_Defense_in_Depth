output "vpc_id" {
	description = "The ID of the VPC."
	value = aws_vpc.main.id
}

output "public_ip" {
	description = "The public IP of the EC2 instance."
	value = aws_instance.windows.public_ip
}

output "instance_dns" {
	description = "The website of the instance."
	value = aws_instance.windows.public_dns
}

output "private_key_pem" {
	value = tls_private_key.main.private_key_pem
	sensitive = true
}

output "key_name" {
	value = aws_key_pair.generated.key_name
}

output "private_key_filepath" {
	value = local_file.private_key.filename		# This should be in your working directory if lines about key in main.tf are correct
}