provider "aws" {
  region = "eu-north-1"
}

# Отримуємо існуючу Security Group
data "aws_security_group" "allow_http_ssh" {
  filter {
    name   = "group-name"
    values = ["allow_http_ssh"]  # Вже існуюча група
  }
}

# Створюємо EC2-інстанс, використовуючи знайдену Security Group
resource "aws_instance" "web" {
  ami           = "ami-02912a5f3748ebfac"
  instance_type = "t3.micro"
  key_name      = "group3key"

  vpc_security_group_ids = [data.aws_security_group.allow_http_ssh.id]

  tags = {
    Name = "Terraform-Managed-Instance"
  }
}
