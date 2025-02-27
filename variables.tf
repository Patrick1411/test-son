variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-1"
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