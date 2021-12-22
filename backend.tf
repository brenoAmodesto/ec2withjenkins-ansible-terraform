terraform {
    backend "s3" {
        region = "sa-east-1"
        bucket = "novinha-safada"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}