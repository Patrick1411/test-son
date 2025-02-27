variable "name" {
  type        = string
  description = "Name of the security group. If omitted, Terraform will assign a random, unique name"
  nullable    = false
}

variable "vpc_id" {
  type        = string
  description = "Security group description. Defaults to Managed by Terraform. Cannot be \"\". NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags"
  nullable    = false
}

variable "description" {
  type        = string
  description = "VPC ID. Defaults to the region's default VPC"
  default     = "Managed by Terraform"
}

variable "ingresses" {
  description = "Configuration block for ingress rules. Can be specified multiple times for each ingress rule. Each ingress block supports fields documented below. This argument is processed in attribute-as-blocks mode"
  default     = []
}

variable "egresses" {
  description = "Configuration block for egress rules. Can be specified multiple times for each egress rule. Each egress block supports fields documented below. This argument is processed in attribute-as-blocks mode"
  default     = []
}