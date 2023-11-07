resource "aws_key_pair" "deployer" {
    key_name = "deployer-key"
    public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

resource "aws_instance" "test-ec2-instance" {
  ami             = "ami-06db4d78cb1d3bbf9"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name
  security_groups = ["${aws_security_group.ingress-all-test.id}"]
  tags = {
    Name = "${var.ami_name}"
  }
  subnet_id = aws_subnet.subnet-uno.id
}