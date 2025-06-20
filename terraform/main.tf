module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  az                 = "us-east-1a"
}

module "sg" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-053b0d53c279acc90" # Ubuntu 20.04 LTS in us-west-1
  instance_type = "t3.medium"
  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_id
  security_group_id  = module.sg.security_group_id


}

module "ec2_shutdown" {
  source      = "./modules/ec2_shutdown"
  instance_id = module.ec2.instance_id
}

