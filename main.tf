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

resource "aws_key_pair" "jenkins-t" {
  key_name   = "mamada2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCcyBTiRmveO0IiAJE0pjAy2gVh58eQCrif+XUz7SKqMDWgPWokctz/mL91ZRGRIMzq7fAwj/Y4bmGXabALnH4rchDeHeErv7p2w7go1BJ41s5tnKi+J9gDcwuONGgcSLyggfkxdL30hQDazMJj6rnDaQm0x0MdIjm20D4XOZ5tbC9juyNTlZ3jDXWyf78KPVgjcoJGrMdoIuyA8wDI0JvFMX/+os1gGeK6GZIeRl0A4ZakfGtdY2pZ7YYwx9CHttAuSVSPj199XXF/NIsX3zy62H1DtMdwPlfHaoRXWL9vfsGTiaojMT9eSO68aMdigueMw1Sh0H0hV1+EZ5eAi7MAbF8tM9QCYKsg+a6JyfvHggN01q8TH0gW8In82V14LhqzKEkWibW93kWr+jbdG58dKkxVGcGPUfInnd+d3ARw9qaU3WbRFWPrdlTa/A0xGkmjxqtQacGU3VcfTMgA6ei8TW2HN9Ev6YvLjE9LtEmcXbOidHpNXm+w38XZFttgy6c= breno@breno-VPCEB15FB"
}

resource "aws_security_group" "all" {

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
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
  key_name               = "mamada2"
  vpc_security_group_ids = [aws_security_group.all.name]

  tags = {
    name = "Jenkins"
    type = "Pipe"
  }

}