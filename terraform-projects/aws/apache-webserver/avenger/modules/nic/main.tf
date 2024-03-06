resource "aws_network_interface" "webserver_nic" {
  subnet_id       = var.subnet_id
  private_ips     = [var.private_ip]
  security_groups = [var.security_group_id]

  tags = {
    Name = "${var.project_name}-nic"
  }
}
