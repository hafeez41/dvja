resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  user_data              = file("${path.module}/../../user-data.sh")

  tags = {
    Name = "dvja-jenkins"
  }
}
