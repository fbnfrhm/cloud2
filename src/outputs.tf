output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.test-ec2-instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.test-ec2-instance.public_ip
}

output "elastic_ip" {
    value = aws_eip.ip-test-env.public_ip
}