


build {
  name = "e2esa-packer-build"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]
  provisioner "file" {
  source = "provisioner.sh"
  destination = "/tmp/provisioner.sh"
  } 
   

provisioner "shell" {
    inline = [
         "chmod a+x /tmp/provisioner.sh",
        # "sudo amazon-linux-extras install -y aws-nitro-enclaves-cli",
        #"sudo amazon-linux-extras install -y aws-nitro-enclaves-cli-devel",
        "sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm",
        "curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm",
        "sudo rpm -U ./amazon-cloudwatch-agent.rpm",
        "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:/mycwagentconfig.json -s",
        "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start"]
 } 
  provisioner "shell" {
    inline = [ "ls -la /tmp"]
  }
  
    provisioner "shell" {
    inline = [ "pwd"]
  }
  
  provisioner "shell" {
    inline = ["/tmp/provisioner.sh"]
  }


}
