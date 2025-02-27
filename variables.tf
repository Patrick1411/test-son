variable "project_name" {
  type        = string
  description = "Project name"
  default     = "aiwa"
}

variable "project_department" {
  type        = string
  description = "Department name"
  default     = "Aiwa department"
}

variable "environment" {
  type        = string
  description = "The environment where your resources will be provisioned"
  default     = "production"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "envshort" {
  type        = string
  description = "prod"
  default     = "prod"
}

variable "main_subnet" {
  type        = string
  description = "Main subnet"
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT gateway"
  default     = false
}

variable "enable_single_nat_gateway" {
  type        = bool
  description = "Enable single NAT gateway"
  default     = false
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key"
}

variable "aws_ecr_repositories" {
  type        = map(string)
  description = "The name of private repositories will be created"
  default    = {
    be        = "ai-construction-drawing-be",
    fe        = "ai-construction-drawing-fe",
    reader    = "ai-construction-drawing-reader",
    converter = "ai-construction-drawing-converter"
  }
}

variable "eks_node_image_type" {
  type        = string
  description = "EKS Worker nodes image type"
  default     = "AL2_x86_64"
}

variable "eks_ai_node_instance_type" {
  type        = list(string)
  description = "EKS Worker nodes instance type"
  default = [
    "t3.large"
  ]
}