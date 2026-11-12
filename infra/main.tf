provider "cloudflare" {}

locals {
  has_custom_domain  = var.domain_name != ""
  pages_project_name = "her-move-berlin"
}

resource "cloudflare_web_analytics_site" "her_move" {
  account_id = var.cloudflare_account_id
  host       = "${local.pages_project_name}.pages.dev"

  # Pages injects the beacon using build_config below; zone injection is unused.
  auto_install = false
}

resource "cloudflare_pages_project" "her_move" {
  account_id        = var.cloudflare_account_id
  name              = local.pages_project_name
  production_branch = "main"

  build_config = {
    web_analytics_tag   = cloudflare_web_analytics_site.her_move.site_tag
    web_analytics_token = cloudflare_web_analytics_site.her_move.site_token
  }
}

resource "cloudflare_zone" "website" {
  count = local.has_custom_domain ? 1 : 0

  account = {
    id = var.cloudflare_account_id
  }
  name = var.domain_name
  type = "full"
}

resource "cloudflare_pages_domain" "apex" {
  count = local.has_custom_domain ? 1 : 0

  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.her_move.name
  name         = cloudflare_zone.website[0].name
}

resource "cloudflare_pages_domain" "www" {
  count = local.has_custom_domain ? 1 : 0

  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.her_move.name
  name         = "www.${cloudflare_zone.website[0].name}"
}

resource "cloudflare_dns_record" "apex" {
  count = local.has_custom_domain ? 1 : 0

  zone_id = cloudflare_zone.website[0].id
  name    = cloudflare_pages_domain.apex[0].name
  type    = "CNAME"
  content = "${cloudflare_pages_project.her_move.name}.pages.dev"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "www" {
  count = local.has_custom_domain ? 1 : 0

  zone_id = cloudflare_zone.website[0].id
  name    = cloudflare_pages_domain.www[0].name
  type    = "CNAME"
  content = "${cloudflare_pages_project.her_move.name}.pages.dev"
  proxied = true
  ttl     = 1
}
