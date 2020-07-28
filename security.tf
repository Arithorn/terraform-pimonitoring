locals {
  application_ports = [80, 443, 3000, 9001, 1883]
  ssh_hosts         = ["154.66.187.15/32"]
}

resource "aws_security_group" "tls_group" {
  name        = "allow_tls"
  description = "Allow TLS from Trusted Hosts"

  ingress {
    description = "TLS From Trusted Hosts"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.ssh_hosts
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group" "grafana_host_group" {
  name        = "grafana_host"
  description = "Allow Grafana Ports"

  dynamic "ingress" {
    for_each = local.application_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "efs" {
  name        = "EFS"
  description = "Allow Access from docker to EFS"

  ingress {
    description     = "Allow Access from docker to EFS on 2049"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = ["${aws_security_group.grafana_host_group.id}"]

  }
}
