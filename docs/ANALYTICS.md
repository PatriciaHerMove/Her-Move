# Her move – website analytics options

Provider documentation and published plan limits checked on **8 November 2026**. Prices and allowances can change; the linked official pages are the reference before choosing a service.

## Recommendation

Handoff constraint: preserve zero operating cost and the existing setup. The alternatives below are dated research, not authorization to add services or enable billing. See [free operation and handoff checks](SETUP.md#free-operation-and-handoff-checks) and [AI maintenance instructions](../AGENTS.md) before considering a change.

Start with **Cloudflare Web Analytics** for free traffic and performance reporting. It is enough to understand whether people are finding the website, which websites refer them, and how the page performs on mobile devices.

If we need to measure booking-button clicks or distinguish campaigns, consider **Umami Cloud Hobby**. Its free hosted allowance currently covers 100,000 events per month for one website. It avoids maintaining an analytics server.

This recommendation reflects our current small, static website. A click on a booking link measures interest; confirmed bookings must come from the booking provider’s reporting or an integration.

Sources: [Cloudflare Web Analytics](https://www.cloudflare.com/web-analytics/), [Umami pricing](https://umami.is/pricing).

## Current project status

- The website is static HTML, CSS and JavaScript in [`public/`](../public/), deployed to `https://her-move.pages.dev`.
- [`infra/main.tf`](../infra/main.tf) creates the Pages project and a Web Analytics site for `her-move.pages.dev`, linking the analytics tag and token to the Pages project. Collection requires applying this configuration and redeploying the website.
- No analytics snippet is present in the checked-in website. Cloudflare can inject one through dashboard settings, so source inspection alone cannot confirm whether analytics is enabled. The account settings have not been inspected.
- The booking section is a placeholder. There is currently no completed booking journey to measure.
- This document does not activate tracking or change infrastructure.
- The [privacy-policy template](../public/datenschutz.html#analyse) explicitly leaves live Web Analytics status unresolved. Complete it for the verified production configuration using [the legal completion guide](LEGAL_TEMPLATES.md); adding a policy does not activate collection or provide consent.

## What Cloudflare provides

Cloudflare has several analytics layers with different purposes:

| Layer | What it tells us | Relevance to Her move |
|---|---|---|
| Web Analytics | Browser traffic and real-user page performance | The starting point for our Pages website; enable it for the project. |
| Domain / edge analytics | Requests received by Cloudflare, bandwidth, caching and security activity | Relevant if we add a custom domain proxied through a zone in our Cloudflare account. Request counts include assets and automated traffic. |
| Workers / Pages Functions metrics | Server-code requests, failures and execution status | The checked-in website has no Pages Functions. These operational metrics do not replace visitor or conversion reporting. |

Sources: [Web Analytics and edge analytics](https://developers.cloudflare.com/web-analytics/faq/), [Pages Functions metrics](https://developers.cloudflare.com/pages/functions/metrics/).

### Free Web Analytics

We can expect:

- **Page views and visits** over time.
- **Referring websites** and traffic by hostname and page path.
- **Country, device type, browser and operating system** breakdowns.
- **Page load timing and Core Web Vitals** to assess the visitor experience.

Cloudflare defines a visit using whether the referring hostname differs from the site hostname. A visit is not a persistent identity or a reliable count of individual people returning over time.

The main website is a single landing page, with separate Impressum and privacy-policy templates. Scrolling to sections such as `#buchung` does not load another HTML document and should not be treated as a separate page view; navigating to a legal page does load a separate document.

Sources: [Metric definitions](https://developers.cloudflare.com/web-analytics/data-metrics/high-level-metrics/), [Available dimensions](https://developers.cloudflare.com/web-analytics/data-metrics/dimensions/).

### Important limits

- Accessible history covers the **previous six months**.
- **Custom events are not supported**, so booking, email and telephone clicks are not recorded as custom conversions.
- **UTM campaign reporting is not supported**. Referring websites do not distinguish every Instagram campaign, newsletter or QR code.
- Browser blockers and failed beacon requests can reduce collection. Use trends rather than treating counts as exact totals.
- Enabling collection does not reconstruct traffic from before tracking was installed.

Cloudflare describes Web Analytics as cookie-free. That does not automatically settle the privacy requirements of a particular configuration.

Sources: [Cloudflare FAQ](https://developers.cloudflare.com/web-analytics/faq/), [Cloudflare privacy approach](https://www.cloudflare.com/web-analytics/).

## Free and alternative options

The public website can stay on Cloudflare Pages with any of these tools. Their browser script sends measurements to a separate analytics service.

| Option | Free allowance or cost | Useful for | Tradeoffs |
|---|---|---|---|
| [Cloudflare Web Analytics](https://www.cloudflare.com/web-analytics/) | Free hosted service; six months of accessible history | Traffic sources, devices and browser performance | No custom events or UTM reports. |
| [Umami Cloud Hobby](https://umami.is/pricing) | Free: 100,000 events/month, one website, six-month retention | Focused website analytics and custom click events | Page views and custom events consume the allowance. Confirm access and plan limits before adoption. |
| [Google Analytics 4](https://marketingplatform.google.com/about/analytics/) | Standard service is free; optional services can cost extra | Campaign reporting, events and Google marketing integrations | More configuration and consent work. Event-level retention differs from aggregate report retention. |
| [PostHog](https://posthog.com/pricing) | 1 million analytics events/month free; free plan includes one project and one-year retention | More detailed event analysis and conversion journeys | More tooling than we currently need. Products have separate allowances; usage plans charge beyond free allowances. |
| [Umami self-hosted](https://docs.umami.is/docs/guides/hosting) | Free software; infrastructure and maintenance extra | Operating analytics under our own control | Requires a Node.js server, PostgreSQL, updates and backups. |
| [Matomo On-Premise](https://matomo.org/pricing/) | Free Community software; infrastructure extra | Broader reporting with control over deployment | Server and database operations; some advanced features require paid plugins. Matomo Cloud is a separate paid service. |
| [Plausible](https://plausible.io/docs/subscription-plans) | Paid managed Cloud; free self-hosted Community Edition software | A focused managed dashboard, or a separately operated service | Cloud’s trial is not a permanent free tier. Community Edition requires infrastructure and differs from Cloud. |

“Free software” does not mean free operation: account for hosting, database storage, backups, upgrades and the maintainer’s time. Self-hosted analytics backends cannot run merely by placing their files in our static Pages deployment.

For GA4, check [Google’s retention documentation](https://support.google.com/analytics/answer/7667196) when configuring the property. For Plausible, see the [Cloud / Community Edition distinction](https://plausible.io/self-hosted-web-analytics). For Umami event tracking, see [Track events](https://docs.umami.is/docs/track-events).

## Which setup should we choose?

| Our question | Suggested setup |
|---|---|
| Are people finding the website, and is it fast? | Cloudflare Web Analytics. |
| Which buttons and campaigns generate booking interest? | Umami Cloud Hobby with a small set of custom events and consistent campaign tags. |
| How do Google marketing campaigns perform? | Evaluate GA4 if its integrations justify the additional setup. |
| Can we operate analytics ourselves? | Evaluate self-hosted Umami or Matomo and assign responsibility for maintenance. |
| Where do people drop out of a complex booking journey? | Evaluate PostHog and the booking provider’s integration capabilities. |

These are project recommendations, not statements that a provider can observe external bookings without integration.

## Enable and verify Cloudflare Web Analytics

### Terraform token requirements

The pinned Cloudflare provider **v5.28.1** supports `cloudflare_web_analytics_site` and the Pages project's `build_config.web_analytics_tag` and `build_config.web_analytics_token` fields. The current Terraform configuration uses these to register `her-move.pages.dev` and enable Pages-managed script injection. `auto_install = false` disables separate zone-level injection; Pages handles injection through its analytics configuration.

To manage analytics through Terraform, the infrastructure API token needs:

| Permission | Purpose |
|---|---|
| **Account → Cloudflare Pages → Edit** | Manage the Pages project and its analytics linkage. |
| **Account → Account Settings → Edit** | Read and manage the Web Analytics site. |

Scope these permissions to the Cloudflare account containing `her-move`. Update the **`TERRAFORM_CLOUDFLARE_API_TOKEN`** repository secret used by both Terraform workflows. Local Terraform runs use the infrastructure token as `CLOUDFLARE_API_TOKEN` in the ignored `infra/.env` file.

The separate **`CLOUDFLARE_API_TOKEN` GitHub Actions secret** used by **Deploy website** only needs Pages Edit; do not add Account Settings permission to that deployment token. R2 state credentials do not change. Zone/DNS permissions are only needed if Terraform also manages the optional custom domain.

Permissions alone do not enable analytics. Follow the apply and redeployment steps below.

Sources: [Web Analytics resource permissions](https://raw.githubusercontent.com/cloudflare/terraform-provider-cloudflare/v5.28.1/docs/resources/web_analytics_site.md), [Pages resource fields and permissions](https://raw.githubusercontent.com/cloudflare/terraform-provider-cloudflare/v5.28.1/docs/resources/pages_project.md). See also [credential setup](SETUP.md#1-cloudflare-api-token).

### Apply the Terraform configuration

1. Update the infrastructure token with the permissions above.
2. If analytics already exists for `her-move.pages.dev`, import its existing site into the shared Terraform state before planning. Use the same backend and infrastructure credentials described in [initial setup](SETUP.md#initial-infrastructure-setup), replacing the placeholders with the actual account ID and Web Analytics site ID:

   ```sh
   terraform -chdir=infra init
   terraform -chdir=infra import cloudflare_web_analytics_site.her_move '<account_id>/<site_id>'
   ```

   The site ID is the Web Analytics identifier, not the Pages project name or analytics token. Skip import if no analytics site exists.
3. Once this change is on `main`, review the **Terraform - Plan** workflow output. Without an imported site, it should create one Web Analytics site and update the existing Pages project in place. With an imported site, it should reconcile that site and update the Pages linkage. Stop if it proposes replacing or deleting the Pages project or changing unrelated infrastructure.
4. Run **Terraform - Apply plan** with the reviewed plan run ID, following [the deployment process](SETUP.md#deploy-the-website).
5. Run **Deploy website** after the apply succeeds. An infrastructure-only merge does not trigger the website workflow, so this redeployment must be started separately.
6. Verify collection using the browser and dashboard checks below.

This configuration targets the current Pages hostname. When adopting a custom domain, review the analytics hostname configuration as part of that change.

### Dashboard setup and verification

Terraform manages the analytics linkage once applied. The dashboard remains useful for viewing reports and verifying collection. For a manual setup instead of Terraform:

1. In the business owner’s Cloudflare account, open **Workers & Pages → her-move → Metrics**.
2. Select **Enable** under Web Analytics. Cloudflare injects its script on the next deployment; avoid installing a second copy manually.
3. Redeploy using the **Deploy website** GitHub Actions workflow, or merge a reviewed change under `public/` to `main`. See [setup and deployment](SETUP.md).
4. Visit `https://her-move.pages.dev` in a browser without an analytics blocker for this check.
5. In browser Developer Tools, confirm `beacon.min.js` loads and a beacon POST succeeds. Leave the page or hide the tab to trigger performance reporting.
6. After processing, check Web Analytics for the correct hostname and date range. Verify collection before drawing conclusions from a quiet dashboard.

If nothing appears, confirm deployment occurred after enabling analytics. Check hostname configuration, blockers, CSP errors and beacon requests. A `Cache-Control: public, no-transform` header can prevent automatic injection. An ordinary GET request to the beacon endpoint is not a valid collection test.

When adding a custom domain later, verify tracking for its hostname and decide whether to include or separate traffic from the Pages address.

Sources: [Official Pages setup](https://developers.cloudflare.com/web-analytics/get-started/), [Data collection](https://developers.cloudflare.com/web-analytics/data-metrics/data-origin-and-collection/), [Troubleshooting](https://developers.cloudflare.com/web-analytics/faq/).

## Proposed measurement plan

Start with weekly trends. Small visitor numbers can make daily conversion percentages misleading, and the repository alone cannot predict visitor or booking volume.

| Business question | Metric | Source |
|---|---|---|
| Is awareness growing? | Visits and referring websites | Cloudflare Web Analytics |
| Does the site work well on phones? | Mobile page performance and Core Web Vitals | Cloudflare Web Analytics |
| Are visitors interested in training? | `booking_click`, `contact_click` | An event-capable tool, after real booking/contact links exist |
| Which campaign generates interest? | Consistent UTM tags on Instagram, QR and newsletter links | A campaign-capable tool such as Umami or GA4 |
| Does interest turn into bookings? | Confirmed bookings, counted separately from outbound clicks | Booking-provider reports or a supported confirmation/webhook integration |

An external booking-link click does not prove a booking happened. Cross-domain and embedded booking flows need support from the chosen provider. Do not infer completed conversions from clicks alone.

### Adding Umami later

Create the website in the owner’s Umami account, add its provided tracker once to `public/index.html`, configure the permitted hostnames, and instrument the selected links. Deploy through the existing workflow and verify each event.

For example, after the tracker is configured, a future booking link could use:

```html
<a href="https://booking-provider.example/our-page"
   data-umami-event="booking_click">Book training</a>
```

The address is illustrative. This records a click, not a confirmed booking. Start with one provider collecting page views unless there is a specific reason to maintain both.

Source: [Umami custom event instructions](https://docs.umami.is/docs/track-events).

## Privacy, ownership and maintenance

For this Berlin business, document the tool, purpose, collected data, retention, processor terms and any required consent before enabling collection. A cookie-free claim is not a blanket legal clearance. GA4 and advertising integrations also need attention to Google’s EEA consent requirements.

- Keep account ownership, recovery access and billing with the business owner, following [the ownership model](SETUP.md#recommended-ownership-model).
- Collect aggregate trends and only a few useful events. Do not send names, emails, health information or booking notes as analytics properties, or put personal information in campaign URLs.
- Leave replay and marketing features disabled unless they serve an agreed purpose and have appropriate configuration.
- For self-hosting, assign responsibility for security updates, backups, access and deletion.
- Review after one month: does the information change decisions? Add tools only when a concrete question remains unanswered.

Sources: [Google consent settings](https://support.google.com/analytics/answer/14275483?hl=en), [German regulator guidance on cookies and tracking](https://www.baden-wuerttemberg.datenschutz.de/faq-zu-cookies-und-tracking-2/).
