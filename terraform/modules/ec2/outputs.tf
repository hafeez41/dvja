output "public_ip" {
  value = aws_instance.jenkins.public_ip
}
output "instance_id" {
  value = aws_instance.jenkins.id
}

