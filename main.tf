terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "currentContext" {}
data "aws_region" "currentContext" {}

locals {
  ingresses_rds = [
    {
      from_port                    = 5432
      to_port                      = 5432
      protocol                     = "tcp"
      referenced_security_group_id =  module.sg_bastion.id
    }
  ]

  ingresses_bastion = [
    {
      from_port                    = 5432
      to_port                      = 5432
      protocol                     = "tcp"
      referenced_security_group_id = module.sg_rds.id
    }
  ]
}

module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  name                    = "test-vpc"
  cidr                    = var.main_subnet
  azs                     = ["${var.region}a", "${var.region}c", "${var.region}d"]
  private_subnets         = [for i in range(3) : cidrsubnet(var.main_subnet, 4, i + 1)]
  private_subnet_names    = [for az in ["a", "c", "d"] : "${var.project_name}-${var.envshort}-private-sub-1${az}"]
  public_subnets          = [for i in range(3) : cidrsubnet(var.main_subnet, 4, i + 4)]
  public_subnet_names     = [for az in ["a", "c", "d"] : "${var.project_name}-${var.envshort}-public-sub-1${az}"]
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.enable_nat_gateway ? var.enable_single_nat_gateway : false
  public_subnet_tags      = {
    "kubernetes.io/cluster/eks-${var.project_name}-${var.envshort}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                                                    = 1
  }
  private_subnet_tags     = {
    "kubernetes.io/cluster/eks-${var.project_name}-${var.envshort}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                                           = 1
  }
}

module "sg_rds" {
  source    = "./modules/security_group"
  name      = "db-sg"
  vpc_id    = module.vpc.vpc_id
  ingresses = local.ingresses_rds
}

module "sg_bastion" {
  source    = "./modules/security_group"
  name      = "bastion-sg"
  vpc_id    = module.vpc.vpc_id
  ingresses = local.ingresses_bastion
}