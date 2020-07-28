resource "aws_secretsmanager_secret" "efsid" {
    name = "efsid"
}

resource "aws_secretsmanager_secret_version" "efs" {
  secret_id     = "${aws_secretsmanager_secret.efsid.id}"
  secret_string = aws_efs_file_system.efs.id
}