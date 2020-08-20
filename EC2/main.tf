resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = var.key_name
  # subnet_id                   = aws_subnet.subnet_a.id
  associate_public_ip_address = true
  # vpc_security_group_ids      = [aws_security_group.allow_tls.id]
}
