provider "aws" {
  region     = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "Terraform_Instance" {
  count                  = 1
  ami                    = "ami-0ed17ff3d78e74700" // Ubuntu 20:04 LTS
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.StandartWeb.id]
  key_name               = "key_diplom"

  tags = {
    Name    = "Created using terraform"
    Owner   = "Itsep"
    Project = "Curse work"
  }
}

resource "aws_security_group" "StandartWeb" {
  name        = "StandartWeb SG"
  description = "Allow 80, 443, 22, 8080 inbound traffic"

  ingress {
    description = "Allow 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "Allow 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 22"
    from_port   = 22
    to_port     = 22
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