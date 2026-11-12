# Her move – website architecture and booking requirements

## Current state

Originally written as architecture research; implementation notes updated on 12 November 2026. The customer brief in [CUSTOMER_REQUIREMENTS.md](CUSTOMER_REQUIREMENTS.md) and the checked-in source describe the current website. Production configuration has not been inspected as part of this update.

Her move is a German-language fitness website for Patricia in Berlin-Köpenick. The landing page contains the customer's four course formats, Thursday/Saturday timetable, prices, Patricia's story and the location at Gute32. Booking, package selection, WhatsApp and telephone actions remain explicitly labelled demos. No provider or live inquiry workflow is integrated. Separate Impressum and privacy-policy templates are linked from every footer and still require completion and review.

## Visitor needs

The final site should let visitors:

- Understand Patricia's training focus and where sessions take place.
- See confirmed offers and times.
- Ask about training or reserve an available place.
- Receive clear confirmation and cancellation information.
- Understand whether payment is required and how it works.

The offers are documented in the customer brief; the exact booking flow and operational policies still need confirmation. Preserve the [free-operation requirement](SETUP.md#free-operation-and-handoff-checks) when evaluating solutions.

## Website architecture

The implementation uses HTML, one stylesheet and JavaScript in `public/`, without a build step or runtime dependencies. The legal pages work without JavaScript. GitHub Actions deploys these files to the `her-move` Cloudflare Pages project. Terraform in `infra/` configures that project, Web Analytics and an optional future custom domain. Actual analytics collection must be checked in the deployed site and account settings; see [analytics notes](ANALYTICS.md).

A static site can display offers and link to a booking or contact service. It cannot maintain live availability or reservations by itself. Any future service must satisfy the cost, privacy and security requirements; adding a backend is not authorized by an ordinary website request. See [AI maintenance instructions](../AGENTS.md).

| Part | Current role |
|---|---|
| Website | Four course formats, supplied timetable/prices, trainer story, location and demo actions |
| Legal pages | Incomplete German Impressum and privacy-policy templates |
| Cloudflare Pages | Hosting and HTTPS |
| Google Maps | Optional location map, loaded after a visitor chooses to display it |
| Booking or contact service | To be selected |

## Booking decision

Before choosing a service, confirm:

1. Whether visitors book group sessions, individual training, or both.
2. Whether places have capacity limits or waiting lists.
3. Whether visitors pay online, on site, or after an invoice.
4. Which information is needed for an inquiry or reservation.
5. Who handles confirmations, cancellations and changes.
6. Whether the visitor-facing flow must be available in German.
7. The monthly cost, payment fees, data protection terms and account ownership.

Two integration patterns remain possible:

- **External booking page:** A link opens the chosen service. This keeps the website simple and lets the service manage availability.
- **Embedded booking flow:** Visitors stay on the site, but the embed's behavior, accessibility and data transfer need review before launch.

The website should use provider-neutral wording until a service and booking flow are confirmed.

For a sourced comparison of possible services, see [booking platforms](BOOKING_PLATFORMS.md). The comparison does not select a provider.

## Page structure

| Section | Purpose |
|---|---|
| Startseite | Introduce Her move, small groups, women and Berlin-Köpenick |
| Kursformate | Explain Beginner Workout, Core & Back, Strength and Full Body |
| Buchen | Display the supplied weekly schedule and demo booking/contact actions |
| Preise | Present the six supplied offers with demo selection actions |
| Über mich | Introduce Patricia, her qualifications and vision |
| Standort und Anfahrt | Show Gute32 and the optional map |
| Impressum / Datenschutzerklärung | Provide clearly marked templates for completion |

## Launch tasks

- Confirm offers, actual times, prices and capacity.
- Choose the booking or contact flow and create its account under the business owner's control.
- Verify the supplied timetable for launch and replace demo actions only with working, tested destinations.
- Check the mobile layout, keyboard navigation and the full inquiry or booking journey.
- Add verified business contact details and complete the [legal templates](LEGAL_TEMPLATES.md).
- Review data transfers from maps, fonts and the eventual booking or contact service.

The booking service should be selected from the confirmed business requirements, then integrated and tested before the site invites visitors to reserve places.
