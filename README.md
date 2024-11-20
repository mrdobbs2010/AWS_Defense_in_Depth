# AWS_Defense_in_Depth
This project demonstrates a defense in depth approach to securing cloud resources using AWS and Terraform.

## Table of Contents
* Overview
* Features
* Architecture
* Prerequisites
* Usage
* Project Structure
* License

## Overview
The AWS Defense in Depth Project applies best practices for securing AWS cloud environments. It includes:
  * A VPC with specified CIDR block.
  * Subnets in defined availability zones.
  * Security groups with tailored ingress and egress rules.
  * EC2 instances configured with SSH and RDP access.
This setup demonstrates a layered approach to security and showcases how to manage resources as code with Terraform.

## Features
  1. Custom VPC:
     * CIDR block: 10.0.0.0/16
  2. Subnets:
     * Availability zone: us-east-2a
     * CIDR block: 10.0.1.0/24
  3. Security groups:
     * Ingress: SSH (22) and HTTPS (443) from trusted IPs.
     * Egress: Open to all outbound traffic.
  4. EC2 Instance:
     * Launches in defined subnet.
     * Associated public IP for SSH/HTTPS.

## Architecture
```
+-----------------------------+
|        AWS Account          |
+-----------------------------+
          |
      +---VPC------------------+
      |  CIDR: 10.0.0.0/16     |
      |                        |
  +---+---+                +---+---+
  | Subnet |                | Subnet |
  | 10.0.1.0/24             | 10.0.2.0/24
  | AZ: us-east-2a          | AZ: us-east-2b
  +---+---+                +---+---+
      |                        |
  +---+-------------------+
  | Security Group         |
  | SSH (22), RDP (3389)   |
  +------------------------+
          |
      +---+---+
      | EC2    |
      | Instance|
      +--------+
```
## Prerequitites
* Terraform: Installed on local machine (v1.5 or later recommended).
* AWS CLI: Installed and configured with credentials.
* Git: For version control.
* Access: An AWS with appropriate IAM permissions.

## Usage
* Clone the repository:
  git clone https://github.com/mrdobbs2010/AWS_Defense_in_Depth.git
  cd AWS_Defense_in_Depth

* Initialize Terraform
  terraform init

* Plan the Infrastructure
  terraform plan

* Apply the configuration and create the resources
  terraform apply

* Access the Instance
  1. Locate the public IP address of the instance (output by Terraform).
  2. Use SSH to connect.
    ssh ec2-user@<instance-public-ip>

## Project Structure
```
AWS_Defense_in_Depth/
├── main.tf               # Main Terraform configuration
├── providers.tf          # Providers for the project
├── versions.tf           # Versions for Terraform and AWS
├── variables.tf          # Variables for the project
├── outputs.tf            # Outputs for public IP, VPC ID, etc.
├── README.md             # Documentation for the project
```
## License
This project is licensed under the MIT License. See the LICENSE{License} file for details.
