output "pages_url" {
  description = "The Her move Cloudflare Pages address."
  value       = "https://${cloudflare_pages_project.her_move.name}.pages.dev"
}

output "cloudflare_nameservers" {
  description = "Set these at the registrar after a custom domain is configured."
  value       = local.has_custom_domain ? cloudflare_zone.website[0].name_servers : null
}

output "custom_domain_url" {
  value = local.has_custom_domain ? "https://${cloudflare_pages_domain.apex[0].name}" : null
}

output "www_url" {
  value = local.has_custom_domain ? "https://${cloudflare_pages_domain.www[0].name}" : null
}
