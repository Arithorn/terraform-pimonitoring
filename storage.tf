resource "aws_efs_file_system" "efs" {
  creation_token = "my-monitoring-efs"

  tags = var.tags
}

resource "aws_efs_mount_target" "efsmt" {
  for_each = data.aws_subnet_ids.default.ids

  file_system_id = aws_efs_file_system.efs.id
  subnet_id = each.key
  security_groups = [aws_security_group.efs.id]
}

output "efs_id" {
    value = aws_efs_file_system.efs.id
}