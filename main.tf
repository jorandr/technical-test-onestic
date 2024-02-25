variable "my_access_key" {
  description = "Access-key-for-AWS"
  default = "no_access_key_value_found"
}

variable "my_secret_key" {
  description = "Secret-key-for-AWS"
  default = "no_secret_key_value_found"
}

provider "aws" {
	region = "us-east-1"
	access_key = var.my_access_key
	secret_key = var.my_secret_key
}
#NETWORK
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24" 
  map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.example.id
}

#INSTANCES
resource "aws_instance" "example" {
	ami = "ami-0440d3b780d96b29d"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.example.id
	user_data = file("scriptWordpress.sh")
	private_ip="10.0.1.10"
	tags = {
		Name = "Wordpress-Terraform"
	}
	vpc_security_group_ids = [aws_security_group.instance.id]
    key_name="onestic"
}
resource "aws_instance" "load_balancer" {
	ami = "ami-0440d3b780d96b29d"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.example.id
	user_data = file("scriptHaProxy.sh")
	private_ip="10.0.1.11"
	tags = {
		Name = "LoadBalancer-Terraform"
	}
	vpc_security_group_ids = [aws_security_group.instance.id]
    key_name="onestic"
}

#SECURITY
resource "aws_security_group" "instance" {
	name = "terraform-network-security-group"
	vpc_id                  = aws_vpc.example.id
	ingress {
		from_port   = -1
		to_port     = -1
		protocol    = "icmp"
		cidr_blocks = ["10.0.1.0/24"] 
	}
	ingress {
		from_port   = 8080
		to_port     = 8080
		protocol    = "tcp"
		cidr_blocks = ["10.0.1.11/32"]
	}

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
    ingress {
        from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
