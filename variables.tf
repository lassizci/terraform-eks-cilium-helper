variable "kubectl_version" {
  description = "kubectl image version"
  type        = string
  default     = "1.33.4"
}

variable "backoff_limit" {
  description = "Backoff limit for the job"
  type        = number
  default     = 10
}
