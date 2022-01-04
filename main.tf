provider "aws" {
    region = "sa-east-1"
}
#Já está criado
#module "s3_bucket" {
#  source = "terraform-aws-modules/s3-bucket/aws"
#  bucket = "novinha-safada"
#  acl    = "private"
#  versioning = {
#    enabled = true
#  }
#
#}

#resource "aws_key_pair" "jenkins-t" {
#  key_name   = "mamada2"
#  
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjg9dI4K4s3QoIoKDakkwQUW63J5LbjObQmdI0d0dERBqefXwLFBJ5UyoVr7V5OLeya2/58eBzy7nbAdo09aMJnPzK8eviEXoze5fBTbBczS+ctKhIq0S8wLCjeEUIiZ0uWnOcPPzt2lAiSSHBxxH5yuaEClXvAy9at4xu2tHetlD/5sn2dHzrcdauY2QCQPNWmYxyZ8/6f9bAjZTTsTOO5EUsIeqFQV5dfKDbGTRN5soqDthLoM/6ma5fsQC2qv3H6Ttdr2WLcjhSivfmxpbFXdTCJep4MKHOeDBujxdRxsakdlnSMCCc8jB/ailW9fdGCeMUO/wAfn+w6Uk4kpKsWZc0fwqCsfL1jL8sLhIU9OELbFhpHlCHFdnp5DV7tl8WJfdqMnvUEdL1qFWW8P7Z+aHRjxo4tPtpnXIQl4uK+aapHmilv57ps5WbnSw+lioYTIuf/JO5NWcXoCA71pDBc5JSx2YUM7eDHraZLyFykrJ9l+IMkQhpgaIZNHx3dXM= user@LAPTOP-H7IK4OEE"
#}


resource "aws_security_group" "all" {

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}


module "ec2_instance" {

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  
  name = "mamada2"
  ami                    = "ami-0e66f5495b4efdd0f"
  instance_type          = "t2.micro"
  key_name               = "jenkins"
  vpc_security_group_ids = [aws_security_group.all.name]

  tags = {
    name = "Jenkins"
    type = "Pipe"
  }

}