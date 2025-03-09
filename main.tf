provider "aws" {
  region = "eu-north-1"
}

# 🔹 Створюємо Security Group
resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Security group that allows SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 🔴 Дозволяє SSH для всіх (можна обмежити)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 🔴 Дозволяє HTTP для всіх
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 🔴 Дозволяє доступ на 8080
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # 🔴 Дозволяє весь вихідний трафік
  }

  tags = {
    Name = "allow_http_ssh"
  }
}

# 🔹 Створюємо інстанс з використанням нової Security Group
resource "aws_instance" "web" {
  ami           = "ami-02912a5f3748ebfac"
  instance_type = "t3.micro"
  key_name      = "group3key"

  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]  # Використовуємо створену SG

  tags = {
    Name = "Terraform-Managed-Instance"
  }
}
