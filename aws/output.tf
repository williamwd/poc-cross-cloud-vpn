output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "vpn_1_public_ip_1" {
  value = aws_vpn_connection.vpn_connection_1.tunnel1_address
}

output "vpn_1_public_ip_2" {
  value = aws_vpn_connection.vpn_connection_1.tunnel2_address
}

output "vpn_1_shared_key_1" {
  value = aws_vpn_connection.vpn_connection_1.tunnel1_preshared_key
}

output "vpn_1_shared_key_2" {
  value = aws_vpn_connection.vpn_connection_1.tunnel2_preshared_key
}

output "vpn_2_public_ip_1" {
  value = aws_vpn_connection.vpn_connection_2.tunnel1_address
}

output "vpn_2_public_ip_2" {
  value = aws_vpn_connection.vpn_connection_2.tunnel2_address
}

output "vpn_2_shared_key_1" {
  value = aws_vpn_connection.vpn_connection_2.tunnel1_preshared_key
}

output "vpn_2_shared_key_2" {
  value = aws_vpn_connection.vpn_connection_2.tunnel2_preshared_key
}
