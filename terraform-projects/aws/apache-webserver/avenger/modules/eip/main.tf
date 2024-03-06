
resource "aws_eip" "public_ip" {
  vpc                       = true
  network_interface         = var.nic_id
  associate_with_private_ip = var.private_ip

  tags = {
    Name = "${var.project_name}-public-ip"
  }
}
