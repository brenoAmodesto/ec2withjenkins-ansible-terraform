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
  
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFdhihtJ/ihWPMJsb8ynlLYbzetYpfrlkcSL5Bca92qxq4XRZ8UFLOu9G4CxpbHUNaA3BL0CbrtrGMonOyWqlT8CPzcbNehO6FRPn0aQpkljdJOVJb+yv4suSH504BRpxHYW8ZF2WAcND8g5/ojeyu97qOSBtkE+oBjCA5VoT3DvJINZIJ86Ec1ns/wAGq/VcefbkPkYWD3s9o34vMrDaYYezYLzVUThxntB1ZO0mrXM0KM/vY3L67PDoCFEvK3JwVvl4koajey+j4M+aprN8IA29Hd1RwvhFsS4Qturqk2gnctQamyFYjmGskUhiuhGaAQcRGfG9VqFn3sMJ4GA8UbSgeSPSrutGwa6DLGmvTJcORS9v786P7VxvDNGXJfpRZheZUnQgNscAR7MH9HldpijmFrMetjfcb5dLidxW9RRiMfR3kfyW0mO5M6GriPjqNH9cTbZGaDYphir23MS+0tSANR2mHR+ECrpaXOpykMzZGg4QxJTQpd/ljESg05xk= ubuntu@i-09aed0533d7441e77"
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