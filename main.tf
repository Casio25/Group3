provider "aws" {
  region = "eu-north-1"
}

# Отримуємо існуючу Security Group за її ID (РЕКОМЕНДОВАНО)
data "aws_security_group" "allow_http_ssh" {
  id = "sg-0d09dc9754d8b9dd6" # Замініть на ID вашої Security Group
}

# Створюємо EC2-інстанс, використовуючи існуючу Security Group
resource "aws_instance" "web" {
  ami           = "ami-02912a5f3748ebfac"
  instance_type = "t3.micro"
  key_name      = "group3key"

  # Використовуємо знайдену Security Group
  vpc_security_group_ids = [data.aws_security_group.allow_http_ssh.id]

  tags = {
    Name = "Terraform-Managed-Instance"
  }
}
