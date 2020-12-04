resource "aws_instance" "linux_instance" {
  ami             = lookup(var.amis, var.region) 
  count           = 1
  subnet_id       = var.subnet 
  security_groups = var.securityGroups 
  key_name        = var.keyName 
  instance_type   = var.instanceType 
  
  tags = {
    Name = var.instanceName
  }

  volume_tags = {
    Name = var.instanceName
  }
  provisioner "file" {
    source      = "/Users/ianhunt/projects/octopus/tf-linux-vm-aws/installTentacle.sh"
    destination = "/tmp/installTentacle.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installTentacle.sh",
      "sudo /tmp/installTentacle.sh",
    ]
  }
  
  # Login to the ec2-user with the aws key.
  connection {
    type        = "ssh"
    user        = "centos"
    password    = ""
    private_key = file(var.keyPath)
    host        = self.public_ip
  }
} 
