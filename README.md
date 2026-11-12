# Her move website

A static fitness training website for Patricia in Berlin-Köpenick, hosted on Cloudflare Pages at `https://her-move-berlin.pages.dev`. The site files are in `public/`; Terraform configuration is in `infra/`.

- [Setup and deployment](docs/SETUP.md)
- [Initial research and architecture](docs/INITIAL_RESEARCH.md)
- [Booking platform comparison](docs/BOOKING_PLATFORMS.md)
- [Website analytics options](docs/ANALYTICS.md)
- [Completing the German legal templates](docs/LEGAL_TEMPLATES.md)
- [AI maintenance instructions](AGENTS.md)
- [Free operation and handoff checks](docs/SETUP.md#free-operation-and-handoff-checks)

To preview the current site, open `public/index.html` in a browser. The courses, weekly timetable, prices and branding follow the customer brief in `docs/Anleitung Webseite.pdf`. Booking, package selection, WhatsApp and telephone buttons are explicitly labelled demos until real provider and contact details are supplied. See [requirements and launch notes](docs/CUSTOMER_REQUIREMENTS.md) for implementation coverage and suggestions.

The footer links to German Impressum and privacy-policy templates in `public/impressum.html` and `public/datenschutz.html`. Their marked fields and unresolved analytics status must be completed and reviewed before publication; they do not make the preview ready to accept bookings.

Routine maintenance stays in `public/` and must preserve secure, free operation. `AGENTS.md` restricts infrastructure changes to necessary, reviewed exceptions. Account permissions and billing settings must enforce the owner's limits: instructions alone cannot guarantee zero costs. Optional domain registration, booking subscriptions and payment processing are outside the free static-site baseline.
