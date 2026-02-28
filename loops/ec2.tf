provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraform" {
    ami = var.ami_id
    #count = 4

    #count = length(var.instances)

    for_each = var.instances
    #for_each = toset(var.instances)
    instance_type = each.value

    #instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow_all.id]
    tags = {
        #Name = var.instances[count.index]
        
        #Name = each.value
        Name = each.key
        
        Terraform = "true"
        Project = "roboshop"
    }
}

resource "aws_security_group" "allow_all" {
  name   = var.sg_name

  egress {
    from_port        = var.egress_from_port
    to_port          = var.egress_to_port
    protocol         = "-1" # -1 means all protocols
    cidr_blocks      = var.cidr
  }

  ingress {
    from_port        = var.ingress_from_port
    to_port          = var.ingress_to_port
    protocol         = var.protocol
    cidr_blocks      = var.cidr
  }

  tags = {
    Name = "allow-all"
  }

}
