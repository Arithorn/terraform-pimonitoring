data "aws_ami" "al2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}
resource "aws_instance" "dockerhost" {
    ami           = data.aws_ami.al2.id
    instance_type = var.instance_type
    user_data = file("user_data")
    security_groups = [aws_security_group.tls_group.name,aws_security_group.grafana_host_group.name]
    key_name = "EC2 Tutorial"
    tags = var.tags
    depends_on = [aws_secretsmanager_secret_version.efs]
    iam_instance_profile = aws_iam_instance_profile.docker_profile.name

}

output "ami" {
    value = [data.aws_ami.al2.id]
}