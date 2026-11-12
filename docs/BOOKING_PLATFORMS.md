# Booking platforms for Her move

As of 8 November 2026. Research for fitness classes and, if needed, personal training in Berlin-Köpenick. Her move is not a yoga studio; the platforms below are assessed for their ability to support fitness services as well. The website remains independent of the booking platform. **No provider has been selected or integrated yet.**

## Comparison requirements

- Online booking and payment in German.
- Five- and ten-session passes with a traceable credit deduction for each attendance.
- Recurring classes with limited places; individual appointments if needed.
- A link or embed on the existing website.
- Clear total costs, including payment processing fees, VAT and any setup fees.
- Documentation that can be reviewed for data processing agreements, subprocessors, data locations and data export.

The customer requirements in `Anleitung Webseite.pdf` now specify the offers, prices and group size: a maximum of six women, four weekly classes, Flex 5 passes, MOVE 4 with monthly renewal, an Early Bird pass and personal training. PayPal and credit card payments are requested. Updated evaluation points and the provisional recommendation are in [CUSTOMER_REQUIREMENTS.md](CUSTOMER_REQUIREMENTS.md#suggestions-and-decisions-before-launch). The pricing table below retains the research from 8 November 2026; it does not represent a provider selection.

## Comparison

| Provider | Publicly listed starting price | Multi-session passes and payments | Assessment and points to verify |
|---|---|---|---|
| [Zenamu](https://zenamu.com/de/pricing/) | Free plan with 30 orders/month; the accessible pricing page did not display a numeric price for Standard | Online payments on the free plan; entry packages from Standard | Interesting for classes and individual appointments. Test five-/ten-session passes, automatic redemption, the actual Standard price and guest booking. [Pricing](https://zenamu.com/de/pricing/), [Packages](https://zenamu.com/de/payments/) |
| [Momoyoga](https://www.momoyoga.com/de/preise) | Free with a 5% platform fee on online payments in addition to Stripe fees; Standard €29/month billed annually or €39/month billed monthly | Free plan: two memberships/class passes; Standard: unlimited | German-language booking and passes are attractive. Test the yoga focus and registration flow from a fitness customer's perspective. [Pricing](https://www.momoyoga.com/de/preise), [Billing details](https://support.momoyoga.com/de/support/solutions/articles/201000109793-wie-funktionieren-die-preispl%C3%A4ne-von-momoyoga-) |
| [Cursio](https://cursio.pro/anbieter) | Starter €0/month plus a 10% transaction fee; Pro €59/month excluding VAT plus a 3.5% transaction fee | According to the provider, ten-session passes and class packages are only available from Pro; online payments through Stripe | Lists fitness and personal training as categories and offers website embedding. Check pass redemption and additional Stripe costs. [Provider information and pricing](https://cursio.pro/anbieter) |
| [Yolawo](https://yolawo.de/preise/) | Individual pricing for an active account; free trial with no time limit | Online payments and other payment methods; five-/ten-session passes not confirmed in the current public offering | Strong focus on clubs and class administration. Ask about pass handling and pricing for Her move. [Pricing](https://yolawo.de/preise/), [Features](https://yolawo.de/) |
| [Eversports Manager](https://wp.eversportsmanager.com/de/preise) | Light from €49/month billed annually or €59/month billed monthly; setup fee from €99, all excluding VAT | Block passes such as ten-session passes and online sales are documented | Extensive studio management and marketplace. Check whether Light includes the required pass features and how referral fees apply. [Pricing](https://wp.eversportsmanager.com/de/preise), [Block passes](https://helpcenter.eversportsmanager.com/de/1.-services) |
| [Class Booking](https://www.class-booking.com/pricing) | Basic €20/month; Pro €40/month, both billed monthly | Online payments through Stripe; punch cards listed in the plan overview and explicitly mentioned for Pro | Supports fitness and individual training; the provider lists a German-language booking page. Test the German administration interface, pass credit deductions and required plan. [Pricing](https://www.class-booking.com/pricing/), [Languages](https://www.class-booking.com/) |

These prices are provider statements as of the research date, not quotations for Her move. Payment processors may charge additional fees. Zenamu's retrieved page did not display numeric plan prices, so the previously recorded €16/month is deliberately not presented here as a current price. The earlier Class Booking price in US dollars and the blanket claim that Cursio class passes are available on the free plan are also not supported by the provider information collected on that date.

## Provisional assessment

Zenamu, Momoyoga and Class Booking are reasonable candidates for a practical trial using a real fitness class, a five-session pass and a ten-session pass. Include Cursio if its marketplace could help attract customers and its fees fit the expected revenue. Yolawo and Eversports may suit more complex class administration. This is a **shortlist for testing, not a provider selection**.

Run the same sequence in every trial: buy a pass, book a class, deduct one credit, cancel, book again, view the remaining balance and export the data as the operator. Also test an individual appointment if personal training will be offered. Only then can usability and actual monthly costs be meaningfully compared.

## Privacy and website integration

A provider being based in Germany or the EU does not, by itself, establish GDPR compliance. Before use, Patricia and a qualified adviser should review the data processing agreement, subprocessors, transfers to third countries, deletion periods, payment processing and privacy notices. For embedded booking widgets, also check whether data is transferred to the provider as soon as the page loads. An external booking link can keep the initial technical integration simpler.

The website now displays the customer's class schedule and prices with explicitly labelled demo actions. Real booking and payment links will follow only after the platform has been selected, configured and fully tested. Update the [privacy-policy template](../public/datenschutz.html) for the actual service before activating it; see [the legal completion guide](LEGAL_TEMPLATES.md).

## Free-operation requirement at handoff

The comparison above is historical research, not authorization to add a paid service. The website must remain free to operate. A plan advertised as free can still charge transaction or payment processing fees; a trial is not a permanent free plan. Do not activate a booking or payment integration unless its costs have been checked against this requirement. See [operating costs and handoff checks](SETUP.md#free-operation-and-handoff-checks) and [AI maintenance instructions](../AGENTS.md).
