# Customer brief: implementation and launch notes

Source: `Anleitung Webseite.pdf`. Implemented 9 November 2026 as a local revision of the existing static Cloudflare Pages website. No production deployment was performed.

## Implemented

- Navigation: Kursformate, Buchen, Preise, Über mich.
- Four course descriptions: Beginner Workout, Core & Back, Strength and Full Body.
- Weekly schedule: Thursday 17:00–18:00 Beginner Workout and 18:15–19:15 Strength; Saturday 10:00–11:00 Core & Back and 11:15–12:15 Full Body. All sessions last 60 minutes; groups have a maximum of six women.
- Free introductory call: 15–20 minutes, goal discussion and suitable course selection, with WhatsApp and telephone demo buttons.
- Pricing cards: Probetraining €15; Drop-in €25; Flex 5 €115 (€23/session), valid three months; MOVE 4 €84/month (€21/session), with start/goal check, progress tracking, minimum three months, monthly renewal thereafter and one month's notice to month-end; Early Bird Flex 5 €95 instead of €115 (€19/session), available until December 2026, valid three months from January 2027; personal training €110 for 60 minutes, individual exercises and training-plan creation. Non-renewal and no-contract terms for Flex 5 and Early Bird match the brief.
- Patricia's supplied story, training qualifications, experience, running interests and vision.
- Green, lime, sage, orange, pink, beige and brown palette; organic shapes; logo symbol, foliage, studio photo and Patricia's photo extracted from the PDF. Roboto and Roboto Condensed are served locally with their licence.
- Location, directions and Google Maps consent controls retained. Responsive navigation, keyboard focus, reduced motion, a skip link and accessible demo dialogs included.

## Deliberate demo behavior

The owner has not supplied business contact details, a booking account or original assets and requested dummies. All course, package and contact action buttons carry a **Demo** label and open a dialog confirming that nothing has been booked, sent or paid. No invented phone number, fake payment form, placeholder third-party account or reservation endpoint is used.

Course descriptions link to the timetable; price and course buttons name the chosen offer in the demo. The footer now links to German Impressum and privacy-policy templates; their missing details remain visibly marked. See [the completion guide](LEGAL_TEMPLATES.md). This preview is not ready to accept bookings.

## Suggestions and decisions before launch

The provider suggestions below predate the zero-operating-cost handoff requirement. They do not authorize a subscription or transaction fees. Keep booking actions as demos until a compatible solution is confirmed; see [free operation and handoff checks](SETUP.md#free-operation-and-handoff-checks).

1. **Test Eversports first with the actual offers.** This is a fit recommendation, not a provider selection. Its documentation describes online product payments using available local methods such as PayPal and credit card, assignment of purchased products to customer accounts and automated invoices. Its recurring-membership documentation lists credit card and optional online SEPA for monthly memberships. Do not promise PayPal for MOVE 4 without a successful test and provider confirmation. Confirm current fees and tariff eligibility directly before signing. Sources: [online payments](https://helpcenter.eversportsmanager.com/de/1-wie-werden-online-zahlungen-abgewickelt), [payment FAQ](https://helpcenter.eversportsmanager.com/de/1-einrichten-der-online-zahlung), [membership creation](https://helpcenter.eversportsmanager.com/de/basisinformation). Reviewed 9 November 2026. The broader [platform comparison](BOOKING_PLATFORMS.md) remains background research.
2. **Run a complete booking trial.** Configure all four weekly classes, six places, each package, upfront payments and MOVE 4 renewal. Test package purchase → reservation → credit deduction → cancellation → refund/recredit → waitlist → membership cancellation. Check whether unused MOVE 4 sessions roll over, cancellation deadlines, no-shows and holiday closures. None of those policies were specified in the PDF.
3. **Clarify the launch and Early Bird dates.** The brief says available until December 2026 and valid three months from January 2027. Confirm the exact sales cutoff, redemption end date and first class date. The website preserves the supplied wording without inventing specific days. Replace or remove the dated offer after the promotion ends.
4. **Add reviewed legal pages and checkout disclosures.** A booking platform does not establish that Patricia's own terms and disclosures are complete. AGB alone should not be treated as a substitute for the complete checkout, cancellation and information process. A qualified adviser should check the distinct treatment of dated courses, flexible credits and recurring memberships. [BGB §312g](https://www.gesetze-im-internet.de/bgb/__312g.html) includes a dated-leisure-service exception to withdrawal rights; do not assume that exception covers every package. [BGB §312k](https://www.gesetze-im-internet.de/bgb/__312k.html) sets requirements for online cancellation of qualifying continuing consumer contracts; verify the MOVE 4 cancellation flow before enabling sales. Add the actual Impressum, privacy policy, business terms and applicable withdrawal information rather than copying the platform's general terms. Review payment, booking, Maps, analytics and any WhatsApp disclosures for the actual configuration.
5. **Use original assets when available.** The supplied room photo is embedded inside a phone screenshot and is currently framed with CSS; it is lower resolution than an original photo. Obtain the original room photo and logo, confirm usage rights and replace the extracted copies. Keep the customer’s identity and studio photographs authentic.
6. **Review the outcome wording.** The Core & Back copy contains the supplied phrase “für … einen schmerzfreien Alltag”. Consider softer language such as “für mehr Stabilität und Wohlbefinden im Alltag” to avoid implying a guaranteed result; the original wording was retained pending customer approval.

## Maintenance

There is no build step or new runtime dependency. Open `public/index.html` to preview. See [SETUP.md](SETUP.md#replace-demo-booking-and-contact-actions) for replacing demo actions. All active CSS lives in `public/styles.css`; the previous override sheet was removed.

## Verification

Headless Chrome checks passed at 320, 390, 768 and 1440 pixels: 14 assertions per viewport covering overflow, offer counts, image/font loading, internal links, initial third-party requests, navigation, all 12 demo actions and map creation/removal with focus restoration. Desktop pricing and mobile timetable were visually reviewed. Google Maps network requests were blocked during the checks; only its consent and iframe lifecycle were verified. JavaScript syntax, local asset references and `git diff --check` also passed. Live booking, payment and contact delivery remain unavailable by design.

## Design refinement: welcoming and personal

The follow-up design brief prioritizes a modern, feminine and encouraging atmosphere with the three core promises visible on arrival: small groups, specifically for women and Berlin-Köpenick. The hero now pairs “Dein Raum. Deine Stärke.” with a prominent location line, three concise benefit columns and a course-selection action. Softer rose, sage and warm neutral surfaces complement the established brand green and original logo. Sentence-case headings, gentler shapes and restrained interactions carry the direction through the courses, prices and about section. The broad green divider below the hero was removed; the full vision remains in the about section. Customer course content, prices and demo behavior remain intact.

The revised design passed 17 browser assertions at each of 320, 390, 768 and 1440 pixels, including visibility of all three hero promises within the first 640 pixels, explicit audience/location wording and removal of the former divider. Mobile and desktop screenshots were reviewed.

Latest visual refinements replace the hero benefit columns with three compact sage badges and change the photo sticker to “Für dich. Mit uns.”. The header subtitle is removed and the gap before courses is reduced. Header and footer share warm cream; courses, pricing and contact share warm white; booking uses blush and the about section uses sage. Pastel course cards retain their individual colours. The current version passed the same 17 browser assertions at all four viewport widths.
