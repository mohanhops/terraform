variable "ingress_ports" {
  type        = list(number)
  default     = [22, 80, 443, 8080]
  description = "List of ports to open"
}


resource "aws_security_group" "roboshop_sg" {
  name        = "roboshop-sg"
  description = "Allow multiple ports dynamically"

  # The "dynamic" keyword starts the loop
  dynamic "ingress" {
    for_each = var.ingress_ports
    
    # 'content' defines what goes inside each block
    content {
      from_port   = ingress.value  # Accesses the current port number
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}