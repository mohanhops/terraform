locals {
  # We calculate the name once here
  instance_name = "${var.project}-${var.component}-${var.env}"
  
  # We create a standard set of tags for the whole project
  common_tags = {
    Project   = var.project
    Terraform = "true"
    Environment = var.env
  }
}

resource "aws_instance" "mongodb" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t2.micro"

  # We use the clean local values here
  tags = merge(local.common_tags, { Name = local.instance_name })
}