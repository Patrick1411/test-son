resource "aws_security_group" "sg" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "rule" {
  for_each                     = {for k, v in var.ingresses : k => v}
  to_port                      = contains(keys(each.value), "to_port") ? each.value.to_port : null
  cidr_ipv4                    = contains(keys(each.value), "cidr_ipv4") ? each.value.cidr_ipv4 : null
  cidr_ipv6                    = contains(keys(each.value), "cidr_ipv6") ? each.value.cidr_ipv6 : null
  from_port                    = contains(keys(each.value), "from_port") ? each.value.from_port : null
  description                  = contains(keys(each.value), "description") ? each.value.description : null
  ip_protocol                  = contains(keys(each.value), "ip_protocol") ? each.value.ip_protocol : "-1"
  prefix_list_id               = contains(keys(each.value), "prefix_list_id") ? each.value.prefix_list_id : null
  security_group_id            = aws_security_group.sg.id
  referenced_security_group_id = contains(keys(each.value), "referenced_security_group_id") ? each.value.referenced_security_group_id : null
}

resource "aws_vpc_security_group_egress_rule" "rule" {
  for_each                     = {for k, v in var.egresses : k => v}
  to_port                      = contains(keys(each.value), "to_port") ? each.value.to_port : null
  cidr_ipv4                    = contains(keys(each.value), "cidr_ipv4") ? each.value.cidr_ipv4 : null
  cidr_ipv6                    = contains(keys(each.value), "cidr_ipv6") ? each.value.cidr_ipv6 : null
  from_port                    = contains(keys(each.value), "from_port") ? each.value.from_port : null
  description                  = contains(keys(each.value), "description") ? each.value.description : null
  ip_protocol                  = contains(keys(each.value), "ip_protocol") ? each.value.ip_protocol : "-1"
  prefix_list_id               = contains(keys(each.value), "prefix_list_id") ? each.value.prefix_list_id : null
  security_group_id            = aws_security_group.sg.id
  referenced_security_group_id = contains(keys(each.value), "referenced_security_group_id") ? each.value.referenced_security_group_id : null
}

output "id" {
  value = aws_security_group.sg.id
}