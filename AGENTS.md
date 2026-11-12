# Instructions for AI assistants maintaining Her move

## Purpose and scope

Help the customer maintain the website with the smallest necessary changes. Preserve secure, free operation. A request to improve the website is not authorization to change infrastructure, buy services or weaken these safeguards.

Before editing, read `README.md`, `docs/SETUP.md` and the documentation relevant to the request. Use `docs/CUSTOMER_REQUIREMENTS.md` and `docs/Anleitung Webseite.pdf` for the customer's brief. `docs/INITIAL_RESEARCH.md` records the architecture and original booking considerations; current source files and the later customer brief describe the implemented site. Platform and analytics comparisons are dated research, not approval to adopt a service. Use `docs/LEGAL_TEMPLATES.md` for changes to legal pages or services that process visitor data.

## Routine website work

- Work in `public/index.html`, `public/styles.css`, `public/script.js` and `public/assets/`. Update relevant documentation when behavior changes.
- `public/impressum.html` and `public/datenschutz.html` are German legal templates linked from every page's footer. Keep them static, accessible without JavaScript and styled through `public/styles.css`.
- Keep plain HTML, CSS and JavaScript, one stylesheet and no build step. Do not add frameworks, package managers, runtime dependencies, servers, databases, Workers or Pages Functions for routine website changes.
- Preserve German visitor-facing copy, Her move branding, authentic customer photos, mobile layouts, accessibility and locally hosted fonts with their licence.
- Make only changes needed for the request. Avoid unrelated rewrites, formatting churn, dependency upgrades and speculative features. Preserve the customer's existing edits.
- Do not invent prices, schedules, qualifications, contact details, legal terms or booking policies. Ask for missing business facts while continuing independent work.

## Free operation is a requirement

- Keep the static Cloudflare Pages setup and existing `pages.dev` address. Do not register a domain, upgrade a plan, start a trial, add a subscription or enable usage-based billing.
- Do not add services that can charge overage, transaction, payment processing, email, SMS, storage or API fees. A free tier, free software licence or free trial alone does not establish free operation.
- For any proposed external service, check current official pricing, allowances, account-wide usage, overage behavior and billing controls. If zero-cost operation cannot be established, explain the limitation and offer a static alternative. Do not activate the service.
- Keep existing Cloudflare Web Analytics as configured; do not add trackers, replay, advertising or other analytics products as an incidental improvement.
- R2 stores private Terraform state and has metered usage beyond its free allowance. GitHub Actions can also charge beyond included usage. Do not expand storage, workflow frequency, artifact retention or runner size. See `docs/SETUP.md` for owner checks; never claim the repository alone guarantees a zero bill.
- Historical paid booking recommendations do not override this requirement. Prefer a verified existing external link when appropriate; never implement payments or store bookings in browser storage as a substitute for a booking system. Linking to a service does not make its operation free.

## Infrastructure is an exceptional change

Treat `infra/**` (including provider locks and backend configuration), `.github/workflows/**`, DNS, account permissions, secrets, billing and hosting settings as protected operational configuration. Do not change them for text, images, colors, layout, schedules, prices, contact links or ordinary website behavior. Do not bypass this rule by making equivalent dashboard, API or CLI changes.

Only prepare an infrastructure change when a concrete requirement cannot be met safely in the static website and the change is genuinely necessary:

1. Explain the requirement, the static alternatives considered and why they cannot meet it.
2. Prepare the smallest reviewable patch. Explain resources affected, security implications, possible costs and rollback. Do not broaden permissions or introduce billable resources to make the task easier.
3. Complete safe local checks first. Do not access live Terraform state or credentials, run a connected plan/import, trigger infrastructure workflows or change remote settings without explicit authorization for that operation.
4. Before any apply or other live infrastructure mutation, obtain the owner's explicit approval of the concrete change and reviewed plan. Follow the existing saved-plan workflow in `docs/SETUP.md`; do not use `terraform apply -auto-approve`, `terraform destroy`, disable locking or bypass plan checks.
5. Stop if a plan unexpectedly deletes or replaces the Pages project, changes account ownership, exposes state or affects unrelated DNS/email. Resolve the discrepancy before proceeding.

Do not migrate or delete the state bucket, rename the Pages project, rewrite workflows or change provider/backend versions as routine cleanup. If a request conflicts with free operation or security, explain the consequence and provide a safe alternative. A vague request such as “make bookings work” is insufficient approval for these operational changes. Do not weaken this file to get around a restriction.

## Security, privacy and truthful behavior

- Never read, print, commit or put secrets in browser code, chat, logs or documentation. Leave `.env`, Terraform state, plans and credentials private and ignored. Use placeholder values in examples.
- Keep least-privilege tokens, separate deployment/infrastructure credentials, private state storage and owner-controlled accounts. Do not weaken HTTPS, access controls or workflow permissions.
- Avoid unsafe HTML injection, executable user input and untrusted scripts. Use text APIs for text; review external URLs and use `rel="noopener noreferrer"` for new-tab links.
- Google Maps must load only after the visitor selects it and be removable. Do not introduce automatic third-party requests, remote fonts, tracking or collection of personal/health/payment data without a specific privacy review and owner approval.
- Booking, package, telephone and WhatsApp actions are demos until verified real destinations and the owner's configured accounts are supplied. Keep demo labels and explanations until replacement actions have been tested. Never claim a reservation, payment or message succeeded without confirmation from the actual service.
- Legal templates contain bracketed fields, editorial notes, visible template notices and `noindex, nofollow` metadata. Preserve these while facts remain unresolved. Do not invent operator details, retention periods, provider contracts, transfer safeguards or legal terms, or declare legal compliance. Use owner-supplied, reviewed information. Follow `docs/LEGAL_TEMPLATES.md` when finalizing the texts and footer status; `noindex` does not restrict public access.
- The privacy template's Web Analytics status is unresolved. Do not infer live collection from Terraform or the absence of a checked-in script. Verify the deployed behavior and account configuration before changing that description, and keep disclosures aligned with the services actually enabled.

## Verification and delivery

- Preview locally by opening `public/index.html`, or use an available local server bound to loopback. No installation or infrastructure access is needed.
- For behavior/layout edits, check relevant interactions, mobile and desktop layout, keyboard navigation/focus, internal links and local assets. Preserve reduced-motion support, map consent and honest demo behavior. Run `node --check public/script.js` when JavaScript changes and Node is available; run `git diff --check` for all patches.
- Scale verification to the change. Do not install a test framework for a small edit or claim checks that were not run.
- Summarize what changed, what was checked and any remaining limitation. Prepare local changes for review; do not push, merge, deploy or trigger workflows unless requested. Changes under `public/` merged or pushed to `main` automatically deploy the site.
