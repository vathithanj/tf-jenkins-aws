variable "instance_count" {
  default = "2"
}

variable "instance_tags" {
  type = list
  default = ["jenkins-ec2", "worker-ec2"]
}
