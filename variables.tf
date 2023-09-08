variable "cluster_version" {
  description = "Version of kubernetes cluster, for matching kubectl image version"
  type        = string
  default     = "1.27"
}

variable "backoff_limit" {
  description = "Backoff limit for the job"
  type        = number
  default     = 10
}
