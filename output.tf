output "aws_instance_public_dns" {
  value = aws_instance.linux_instance.public_dns
}
