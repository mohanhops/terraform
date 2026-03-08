resource "aws_instance" "web" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t2.micro"

  # 1. Connection settings for SSH
  connection {
    type        = "ssh"
    user        = "centos"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  # 2. Run commands on the new server
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y nginx",
      "sudo systemctl start nginx"
    ]
  }

  # 3. Run a command on your MacBook
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> server_ips.txt"
    when = destroy #to de-register from the database 
  }
}