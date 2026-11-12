variable "cloudflare_account_id" {
  description = "Cloudflare account ID, supplied through TF_VAR_cloudflare_account_id."
  type        = string
}

variable "domain_name" {
  description = "Optional future apex domain, such as example.de. Leave empty to use only pages.dev."
  type        = string
  default     = ""

  validation {
    condition     = var.domain_name == "" || (!startswith(var.domain_name, "www.") && can(regex("^[a-z0-9](?:[a-z0-9-]*[a-z0-9])?(?:\\.[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)+$", var.domain_name)))
    error_message = "Use a lowercase apex domain without a scheme, path, or www prefix, or leave it empty."
  }
}
