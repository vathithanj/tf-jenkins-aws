resource "aws_instance" "jks_cicd_ec2" {

  count= var.instance_count
  ami = "ami-0c4f7023847b90238"
  instance_type = "t2.micro"
  key_name = "jks_keypair"
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = element(var.instance_tags, count.index)    
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      public_key  = file("/home/ubuntu/.ssh/id_rsa.pub")
      timeout     = "2m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "jks_keypair" {
  key_name   = "jks_keypair"
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}