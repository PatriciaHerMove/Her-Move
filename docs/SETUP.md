# Her move – setup, ownership and deployment

This project is designed so the business owner keeps control of every important account and can continue operating the website without the original developer. The owner should create and retain the GitHub and Cloudflare accounts, own the repository and billing relationship, and invite contributors only when support is needed.

The Her move fitness website is a static site in `public/`. Terraform in `infra/` configures the Cloudflare Pages project `her-move-berlin`, available at `https://her-move-berlin.pages.dev`. No custom domain or DNS records are created until a domain is chosen. The booking provider has not been selected. The page now contains the customer’s four courses, Thursday/Saturday timetable and pricing from `Anleitung Webseite.pdf`. Booking and contact actions are explicitly labelled demos; they do not reserve, charge or contact anyone. See [customer requirements and launch notes](CUSTOMER_REQUIREMENTS.md).

## Free operation and handoff checks

The maintenance requirement is **zero operating cost**. Keep the static website on Cloudflare Pages Free at its existing `pages.dev` address without Functions, paid add-ons or new services. [Static asset requests are free and unlimited](https://developers.cloudflare.com/pages/functions/pricing/); this does not make every product in the account free.

Before handoff, the owner should verify:

- **Cloudflare:** Confirm actual account plans and enabled products. R2 stores private Terraform state and has billable usage beyond its Standard storage free allowance. Check account-wide storage and operations; Infrequent Access has no free tier. Keep this bucket private and limited to state. Do not delete or migrate it to avoid billing without a separately reviewed state migration. See [R2 pricing](https://developers.cloudflare.com/r2/pricing/).
- **GitHub:** Standard hosted runners are free for public repositories. Private repositories have included compute and storage allowances, with additional usage potentially billed to the owner. Check the current plan and usage, keep paid usage blocked, and verify the scope and stop-usage settings of relevant metered-product budgets. Alerts alone do not stop spending. Keep the existing standard runner and short plan-artifact retention. Do not make the repository public merely to avoid charges; review customer content and history separately. See [Actions billing](https://docs.github.com/en/billing/concepts/product-billing/github-actions) and [budget controls](https://docs.github.com/en/billing/concepts/budgets-and-alerts).
- **Optional services:** Keep the custom domain unset for the free baseline. Registration/renewal, booking subscriptions, payment processing and messaging services can cost money. Historical platform and analytics comparisons do not authorize activation. Check actual costs before considering any integration.
- **Launch readiness:** Confirm ownership, recovery access and deployment access. Complete and review the [legal templates](LEGAL_TEMPLATES.md), verify live analytics status and replace demos only after the real destinations and workflows have been tested. Handing over the repository does not make the site ready to accept bookings.

Provider references checked on 12 November 2026. Live account usage, billing controls and production behavior have not been verified as part of this handoff change. The repository cannot enforce a universal spending cap, especially for metered R2 usage. Resolve those account-level limits before promising guaranteed zero costs.

Give future AI assistants [AGENTS.md](../AGENTS.md). It keeps routine work in the website and restricts infrastructure changes to necessary, reviewed exceptions. These instructions do not replace account permissions or billing controls.

## Recommended ownership model

The business owner should:

- Create the GitHub account and repository, or create a GitHub organization owned by the business.
- Create the Cloudflare account and keep its verified email, recovery methods, billing details and two-factor authentication under her control.
- If a paid custom domain is later approved, register it in her own name or the business name, preferably with a registrar separate from the developer. No domain purchase is needed for the free `pages.dev` address.
- Own the account for whichever booking service is selected and any other third-party services used by the site.
- Store the recovery codes and a short inventory of services and billing dates somewhere private and accessible to the business.

The developer can then be invited as a collaborator and given only the access needed to build and maintain the site. The developer should not be the sole owner, billing contact, recovery contact or holder of the only copy of a credential.

For a single-person business, a repository under the owner's GitHub account is sufficient. A GitHub organization owned by the business is preferable if more people may support the business later.

## Accounts and access to create before development

The owner creates these accounts personally:

1. **GitHub** – create the repository, for example `her-move-website`, and keep ownership. Enable two-factor authentication and save recovery codes.
2. **Cloudflare** – create or use the business Cloudflare account. Add the website to this account and keep the account ID, recovery methods and billing ownership.
3. **Domain registrar (optional)** – only if a custom domain and its costs are explicitly approved, register it in the owner's name/business name. Do not transfer domain ownership to a developer.
4. **Booking service (optional)** – select one only after the requirements and costs are confirmed, then create the account under the owner's control. No booking account is needed for the current demo.

After the repository exists, the owner invites the developer through the repository's access settings. A [personal-account repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/repository-access-and-collaboration/permission-levels-for-a-personal-account-repository) has owner and collaborator access; granular roles such as Maintain belong to organization repositories. For an organization, choose the lowest role that supports the specific work. The owner should manage secrets and sensitive settings and retain ownership. Grant administrative access only for a specific task, then reduce it again.

## Cloudflare credentials and Terraform state

Terraform uses two different kinds of credentials. They must not be confused.

### 1. Cloudflare API token

Create this in the owner's Cloudflare account under **My Profile → API Tokens**. Use a narrowly scoped token for the account:

- **Account → Cloudflare Pages → Edit**
- Add **Account → Account Settings → Edit** when Terraform will manage Web Analytics through `cloudflare_web_analytics_site`. Scope account permissions to the account containing `her-move-berlin`.
- Add **Zone → Zone → Edit** and **Zone → DNS → Edit** only when Terraform will manage a custom domain and its DNS records.

Give the token an expiry date where practical. Save the raw token once in the owner's password manager; Cloudflare will not show the full token again. The token is used locally during initial setup and is later stored as a GitHub Actions secret.

For Terraform-managed analytics, update the token stored in **`TERRAFORM_CLOUDFLARE_API_TOKEN`** so both the plan and apply workflows can read and manage the analytics resource. For local Terraform runs, supply that token as `CLOUDFLARE_API_TOKEN` in the ignored `infra/.env` file. The separate **`CLOUDFLARE_API_TOKEN` GitHub Actions secret** is only for website deployment and does not need Account Settings permission. R2 state credentials remain separate.

Terraform configures a Web Analytics site for `her-move-berlin.pages.dev` and links it to the Pages project, so Account Settings Edit is required for the current configuration. Apply the reviewed infrastructure plan, then redeploy the website to activate script injection. If analytics was already enabled manually, [import the existing resource first](ANALYTICS.md#apply-the-terraform-configuration). Provider references: [Web Analytics permissions](https://raw.githubusercontent.com/cloudflare/terraform-provider-cloudflare/v5.28.1/docs/resources/web_analytics_site.md), [Pages permissions](https://raw.githubusercontent.com/cloudflare/terraform-provider-cloudflare/v5.28.1/docs/resources/pages_project.md).

### 2. R2 S3-compatible credentials for Terraform state

Create the private R2 bucket named in [`infra/versions.tf`](../infra/versions.tf) in the owner's Cloudflare account. Then create an R2 API token scoped to this bucket with **Object Read & Write** access. Record its access key ID and secret access key in the owner's password manager.

This bucket contains Terraform's shared state. It is not the website's public storage. Do not make it public, commit state to Git, or send the secret access key by email or chat. The bucket must exist before `terraform init`.

If the developer stops supporting the project, the owner can revoke both tokens and create replacements without changing ownership of the Cloudflare account or repository.

## Initial infrastructure setup

Run these commands from the repository root. Terraform 1.10 or later is required.

This section is for explicitly authorized infrastructure setup, not routine website edits. Prepare and review the configuration first; obtain owner approval before live infrastructure changes. An existing site normally needs no setup rerun.

1. Copy the example environment file and protect it:

   ```sh
   cp infra/.env.example infra/.env
   chmod 600 infra/.env
   ```

2. Edit `infra/.env` and set the owner's Cloudflare account ID, the setup Cloudflare API token, and the R2 access key and secret. Load it only in the shell used for setup:

   ```sh
   . infra/.env
   ```

3. Initialize, review and apply the infrastructure:

   ```sh
   terraform -chdir=infra init
   terraform -chdir=infra plan
   terraform -chdir=infra apply
   terraform -chdir=infra output pages_url
   ```

The Cloudflare Pages project is created by Terraform. `infra/.env`, Terraform state and plan files are ignored by Git. Never force-add them.

## GitHub Actions secrets and variables

The owner should add these under the repository's **Settings → Secrets and variables → Actions**. Secrets are encrypted and are not visible to collaborators after saving them.

### Repository secrets

| Secret | Value | Used by |
|---|---|---|
| `CLOUDFLARE_ACCOUNT_ID` | Owner's Cloudflare account ID | Website and Terraform workflows |
| `CLOUDFLARE_API_TOKEN` | Pages deployment token: Account → Cloudflare Pages → Edit | [`deploy.yml`](../.github/workflows/deploy.yml) |
| `TERRAFORM_CLOUDFLARE_API_TOKEN` | Terraform token: Pages Edit; Account Settings Edit when managing Web Analytics; Zone and DNS Edit when managing a custom domain | Terraform plan/apply workflows |
| `R2_ACCESS_KEY_ID` | R2 state bucket access key ID | Terraform plan/apply workflows |
| `R2_SECRET_ACCESS_KEY` | R2 state bucket secret access key | Terraform plan/apply workflows |
| `TF_PLAN_PASSPHRASE` | A strong, separate passphrase | Encrypting the reviewed Terraform plan |

Use separate tokens for deployment and infrastructure so the deployment token can remain limited to Pages Edit while Terraform has the additional Account Settings permission. Separate tokens also make revocation and auditing easier.

### Repository variable

Add `CUSTOM_DOMAIN` only after a domain has been registered and DNS migration is ready. Its value is the lowercase apex domain, such as `example.de`, without `https://`, a path or the `www.` prefix. Leave it unset while using only the `pages.dev` address.

## Deploy the website

The [deployment workflow](../.github/workflows/deploy.yml) publishes `public/` to the `her-move-berlin` Pages project when changes reach `main`; it can also be started manually. Changes to that workflow also trigger deployment. Opening a feature-branch PR does not deploy the website. Ordinary website updates use the existing Pages project and do not require a Terraform run.

Before applying Terraform, confirm the reviewed plan targets the existing `her-move-berlin` project. Stop if it proposes deleting or replacing a Pages project. Reconcile any state mismatch under a separately reviewed infrastructure operation; changing the deployment target alone does not update Terraform state.

Infrastructure changes follow a reviewable two-step process:

1. The [Terraform plan workflow](../.github/workflows/terraform-plan.yml) runs when `infra/` changes on `main`.
2. Review the plan output. If it contains changes, start the [Terraform apply workflow](../.github/workflows/terraform-apply.yml) with that plan's run ID within one day. It applies the encrypted plan for the same `main` commit.

The owner can do all of this from GitHub's Actions tab. A developer may prepare pull requests and review plans, but production changes should be understandable and approved by the owner.

## Google Maps and privacy before launch

The contact section shows `Gute32, Gutenbergstraße 32, 12557 Berlin` and the entrance note `Laden außen rechts`, along with an optional Google Maps embed. The iframe is created only after a visitor selects **Karte laden**; **Karte schließen** removes it. Consent is not remembered across visits. The separate directions link opens Google Maps only when selected.

Before publishing, confirm the displayed entrance note and complete the German [privacy-policy template](../public/datenschutz.html), covering the Google Maps embed, its data transfer to Google, and the other services actually used by the website. The footer links to this template and the [Impressum template](../public/impressum.html); both remain visibly incomplete. Follow [the completion guide](LEGAL_TEMPLATES.md) before removing their template notices. Roboto and Roboto Condensed are bundled locally in `public/assets/fonts/`, including their licence. No Google Fonts request is made on page load.

## Replace demo booking and contact actions

The `.dummy-action` buttons in `public/index.html` use `data-offer` to name the selected course or product. `public/script.js` opens a native dialog explaining that no booking or payment occurred. Replace these buttons with the provider’s real course/product links after the business account, payment methods, capacities and policies have been configured and tested. Remove the demo handler, dialog, labels and notice together once all actions are live.

Replace the WhatsApp and telephone buttons only after Patricia supplies a verified business number and approves these contact channels. No dummy number or payment endpoint is used. Complete and review the linked legal templates and update their footer status before launch. Update privacy disclosures for any newly activated service.

The PDF’s photos and logo were extracted into `public/assets/`. The studio image is a phone screenshot; CSS frames only its photo area. Replace it with the original room photo when available. Keep `styles.css` as the single stylesheet.

## Add a custom domain later

After the owner registers a domain:

This is an optional operational change outside the free baseline; follow the necessity, cost and owner-review requirements in [AGENTS.md](../AGENTS.md) before proceeding.

1. Confirm that the domain is in the owner's registrar and Cloudflare account.
2. Set `TF_VAR_domain_name` locally in `infra/.env` and add the same apex domain as the `CUSTOM_DOMAIN` Actions variable.
3. Run a Terraform plan and review it carefully before applying it.
4. Follow Cloudflare's nameserver instructions at the registrar. Check existing DNS records before changing nameservers; changing them can affect email and other services.

Terraform then creates the Cloudflare zone, Pages custom domains, and the proxied apex and `www` CNAME records. The `cloudflare_nameservers`, `custom_domain_url` and `www_url` outputs become available.

## How support can end cleanly

The owner can take over without rebuilding the site:

1. Confirm she can sign in to GitHub, Cloudflare, the domain registrar and any chosen booking service, and that recovery codes are available.
2. Confirm the repository's default branch is `main`, Actions are enabled, and the owner can run the deployment and Terraform workflows.
3. Ask the departing developer to document any pending work, local-only configuration and third-party services.
4. Rotate or revoke the developer-created Cloudflare API tokens and R2 credentials. Update the corresponding GitHub Actions secrets with owner-created replacements.
5. Remove the developer from GitHub collaborators, Cloudflare members/API tokens, the domain registrar and any chosen booking service when access is no longer needed.
6. Keep the repository, Terraform state bucket, Pages project, domain and any booking account. Do not delete them as part of offboarding.

The code and workflows are intentionally stored in the owner's repository, and the Terraform state is stored in the owner's R2 bucket. This means the developer's departure removes support access, not the business's ability to operate the website.

## Security and operating checklist

- Use two-factor authentication on GitHub, Cloudflare, the registrar and any chosen booking service.
- Keep recovery codes in the owner's password manager or another secure offline location.
- Use separate tokens for website deployment and infrastructure where possible.
- Give collaborators the lowest role that supports their work; review access periodically.
- Never commit `.env` files, Terraform state, plan files, API tokens or R2 secrets.
- Review Terraform plans before applying them, especially DNS changes.
- Keep legal pages, privacy information, disclosures for any chosen booking or contact service, and business contact details current. See [initial research](INITIAL_RESEARCH.md) for the site's structure and open booking requirements.

## Local preview

Open `public/index.html` in a browser. The site has no build step.
