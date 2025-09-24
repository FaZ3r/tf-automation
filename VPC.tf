resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_internet_gateway" "gatewayT"{
    vpc_id = aws_vpc.demo_vpc.id
}

resource "aws_subnet" "MySubnet1"{
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "eu-west-2a"
    map_public_ip_on_launch = true

}

resource "aws_subnet" "MySubnet2"{
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "eu-west-2b"
    map_public_ip_on_launch = true
}

resource "aws_security_group" "new_sec_group" {
  vpc_id = aws_vpc.demo_vpc.id
  name   = "demo-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



