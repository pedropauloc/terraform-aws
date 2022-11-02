resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# this resource will create a key pair using above private key
resource "aws_key_pair" "mykeypair" {
  key_name   = "galpkey"
  public_key = tls_private_key.private_key.public_key_openssh

  depends_on = [tls_private_key.private_key]
}

# this resource will save the private key at our specified path.
resource "local_file" "saveKey" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "galpkey.pem"

}