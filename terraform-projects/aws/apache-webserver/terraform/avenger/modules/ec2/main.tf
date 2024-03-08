data "aws_availability_zones" "available_zones" {}

resource "aws_instance" "web_server_instance" {
  ami               = var.ec2_ami
  instance_type     = var.ec2_instance_type
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  key_name          = var.ssh_key_name

  network_interface {
    device_index         = 0
    network_interface_id = var.nic_id
  }

  user_data = <<-EOF
     #!/bin/bash
     sudo apt update -y
     sudo apt install apache2 -y
     sudo systemctl start apache2
     sudo bash -c "echo ${var.project_name}  webserver > /var/www/html/index.html"
      EOF

  tags = {
    Name = "${var.project_name}-web-server-instance"
  }
}
