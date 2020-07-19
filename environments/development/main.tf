module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "example-vpc"
  cidr = "10.12.0.0/16"

  azs             = ["${data.aws_availability_zones.available.names[0]}", "${data.aws_availability_zones.available.names[1]}", "${data.aws_availability_zones.available.names[2]}"]
  intra_subnets = ["10.12.101.0/24", "10.12.102.0/24", "10.12.103.0/24"]
  public_subnets  = ["10.12.1.0/24", "10.12.2.0/24", "10.12.3.0/24"]

  public_subnet_suffix = "public"
  public_subnet_tags = {
    Type = "public"
  }

  intra_subnet_suffix = "intra"
  intra_subnet_tags = {
    Type = "intra"
  }


  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}
