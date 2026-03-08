variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "sg_name" {
  type        = string
}

variable "sg_description" {
  type        = string
  default     = "Allow all inbound traffic for RoboShop dev"
}

variable "vpc_id" {
    type = string
}

variable "sg_tags" {
    type = map
    default = {}
}