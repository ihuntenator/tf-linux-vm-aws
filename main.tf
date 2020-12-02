# create a Linux instance in AWS
# execute bash script to set up Ansible client user

resource "aws_instance" "linux_instance" {
  ami             = lookup(var.amis, var.region) 
  subnet_id       = var.subnet 
  security_groups = var.securityGroups 
  key_name        = var.keyName 
  instance_type   = var.instanceType 
  
  # Name the instance
  tags = {
    Name = var.instanceName
  }
  # Name the volumes; will name all volumes included in the 
  # ami and the ebs block device from above with this instance.
  volume_tags = {
    Name = var.instanceName
  }
  provisioner "file" {
    source      = "~/projects/Octopus/tf-splunk-vm-aws/installTentacle.sh"
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
    user        = "develop"
    password    = ""
    private_key = file(var.keyPath)
    host        = self.public_ip
  }
} # end resource
