data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical/Ubuntu
}


resource "aws_key_pair" "ansible_aws" {
  key_name   = var.key_name
  public_key = file("${var.key_path}.pub")
}


resource "aws_security_group" "ssh_http" {
  name        = "ssh_http"
  description = "Allow SSH and HTTP"

  ingress {
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


resource "aws_instance" "ansible" {
  ami = data.aws_ami.ubuntu.id

  count         = var.ansible_count
  instance_type = var.ansible_instance_type
  key_name      = aws_key_pair.ansible_aws.key_name

  security_groups = [aws_security_group.ssh_http.name]

  tags = {
    Name = "AWX"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.user_ec2
      host        = self.public_ip
      timeout     = "2m"
      private_key = file(var.key_path)
    }

    inline = [
      "sudo hostname awx-0${count.index}",
      "echo awx-0${count.index} | sudo tee /etc/hostname"
    ]
  }

}

