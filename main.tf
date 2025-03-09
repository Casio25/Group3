provider "aws" {
  region = "eu-north-1"
}

# Отримуємо існуючу Security Group за її ім'ям
data "aws_security_group" "allow_http_ssh" {
  filter {
    name   = "group-name"
    values = ["launch-wizard-1"]  # Замініть на реальну групу з `aws ec2 describe-security-groups`
  }
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
