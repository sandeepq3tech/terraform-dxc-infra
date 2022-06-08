# creating instance.
resource "aws_instance" "web" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "first-tf-instance"
  }
  user_data = file("${path.module}/script.sh")
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }
  provisioner "file" {
    source = ".env"
    destination = "/home/ec2-user/.env"
  }

  provisioner "file" {
    source = "init.sh"
    destination = "/home/ec2-user/init.sh"
  }
  provisioner "file" {
    source = "docker-compose.yml"
    destination = "/home/ec2-user/docker-compose.yml"
  }
  provisioner "file" {
    source = "drive"
    destination = "/home/ec2-user/drive"
  }
}
# create security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"


  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "TLS from VPC"
    from_port   = 8181
    to_port     = 8181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "TLS from VPC"
    from_port   = 8282
    to_port     = 8282
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}



