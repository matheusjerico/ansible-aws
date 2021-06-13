output "anbisle_public_ip" {
  value = aws_instance.ansible[*].public_ip
}

output "ansible_tag_name" {
  value = aws_instance.ansible[*].tags.Name
}

output "ansible_ssh" {
  value = formatlist("ssh %s@%s", var.user_ec2, aws_instance.ansible[*].public_dns)
}