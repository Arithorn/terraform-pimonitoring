data "aws_route53_zone" "selected" {
  name = "smartdevops.net."
}

resource "aws_route53_record" "pi" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "pi.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.dockerhost.public_ip]
}
