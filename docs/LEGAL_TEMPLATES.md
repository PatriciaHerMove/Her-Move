# Completing the German legal templates

Templates prepared on 12 November 2026 for the existing static website. They provide a starting point based on current German/EU requirements, not a guarantee of legal compliance. Complete them with verified business facts and have the actual setup and wording reviewed before launch.

## Files and scope

- [`public/impressum.html`](../public/impressum.html): operator identification and contact details, conditional business disclosures and a consumer dispute resolution field.
- [`public/datenschutz.html`](../public/datenschutz.html): controller, hosting, local assets, optional Google Maps, unresolved analytics status, contact handling and data subject rights.
- The home page and both templates link directly to these pages in their footer. They use the existing stylesheet and local assets; the legal pages need no JavaScript.

All bracketed fields are intentional placeholders. Both pages display a template notice and include `noindex, nofollow` while incomplete. This indexing instruction does not restrict public access. No AGB, withdrawal information or checkout terms have been invented; these depend on the chosen offers and booking flow.

## Complete before publication

1. Supply the full operator name or registered business name, legal form/representation where applicable, serviceable legal address, business email and direct contact method. Do not assume the training venue is the operator's legal address. Fill both pages consistently. Publish relevant VAT/business identification numbers, not a private tax number. Review the conditional fields, including any register entry, regulated profession or supervisory authority.
2. Confirm the operator's dispute-resolution obligations and willingness before inserting a statement. Section 36(3) VSBG exempts businesses with no more than ten employees on 31 December of the preceding year from the information duty in section 36(1)(1); it does not erase an applicable duty under section 36(1)(2). Do not automatically insert a refusal to participate.
3. Verify the Cloudflare contracting entity, processing agreement, actual logging, retention and recipients. Identify applicable international transfer arrangements and how to obtain safeguards. Do not claim EU-only hosting, a signed agreement, fixed retention or a current certification without checking.
4. Inspect the deployed site and Cloudflare settings for Web Analytics and any other injected code. The Terraform configuration alone does not establish live collection. Replace the unresolved analytics section with the actual configuration, data, purpose, lawful basis, retention and rights. If consent is required, implement it before collection; a policy alone does not provide consent. Do not enable, disable or change infrastructure merely to finish this template.
5. Review the actual Maps integration, provider address, data transfers, retention and consent information. The page now explains that loading is voluntary and links to the policy before loading. Closing removes the iframe; it cannot erase previously sent data or Google cookies. Verify the legal basis and transfer safeguards for the actual service; do not use consent as a blanket substitute for transfer requirements.
6. Add the real email/telephone providers and retention rules when contact details are supplied. Add service-specific disclosures before activating WhatsApp, booking or payment. Do not describe demo actions as active services. Confirm whether a data protection officer is appointed and whether any automated decision-making occurs.
7. Remove all bracketed fields and editorial instructions after resolving them; remove conditional sections that do not apply. Update the notice, footer status, page titles, descriptions and robots metadata to reflect final texts. Keep the footer links clearly labelled and directly accessible. Recheck the policy whenever services or data flows change.

## Official references

- [Section 5 DDG](https://www.gesetze-im-internet.de/ddg/__5.html): provider identification and conditional disclosures. Use the current DDG reference rather than the former section 5 TMG.
- [Section 36 VSBG](https://www.gesetze-im-internet.de/vsbg/__36.html): consumer dispute resolution disclosures and the limited small-business exception.
- [European Commission: discontinued ODR platform](https://consumer-redress.ec.europa.eu/site-relocation_en): discontinued on 20 July 2025. No obsolete ODR platform link has been added.
- [GDPR](https://eur-lex.europa.eu/eli/reg/2016/679/oj?locale=de) and [European Commission: individuals' rights](https://commission.europa.eu/law/law-topic/data-protection/information-individuals_en): transparency, lawful processing and rights. The EUR-Lex page required a browser verification challenge during research; the Commission guidance was accessible.
- [TDDDG, including section 25](https://www.gesetze-im-internet.de/ttdsg/BJNR198210021.html): storing or accessing information on end devices. [German regulator guidance](https://www.lfd.niedersachsen.de/startseite/infothek/faqs_zur_ds_gvo/faq-telekommunikation-digitale-dienste-datenschutzgesetz-tdddg-206449.html) explains the rules.
- [Irish Data Protection Commission: retention](https://www.dataprotection.ie/en/faqs/responsibilities-data-controllers/how-long-should-personal-data-be-held-meet-obligations-imposed-gdpr): retention depends on purpose and applicable duties; the GDPR does not prescribe one universal period.
- [Cloudflare privacy policy](https://www.cloudflare.com/privacypolicy/), [processing agreement](https://www.cloudflare.com/cloudflare-customer-dpa/) and [Web Analytics collection](https://developers.cloudflare.com/web-analytics/data-metrics/data-origin-and-collection/): verify against the owner's actual services and contract.
- [Google privacy policy](https://policies.google.com/privacy?hl=de): provider processing and transfers for Maps.
- [Berlin data protection authority: complaints](https://www.datenschutz-berlin.de/buergerinnen-und-buerger/beschwerde/einreichen-einer-beschwerde).

No account settings, infrastructure, tracking configuration or deployment were changed to add these templates.

## Local verification

Headless Chrome checks passed for the home page and both legal pages at 320, 390, 768 and 1440 pixels: no horizontal overflow, legal footer links present, one main heading per page, eager images loaded and legal body text readable. The map load/close controls, focus restoration and a demo dialog were also checked. Mobile privacy-policy and desktop Impressum screenshots were reviewed. External network requests were blocked, so Google Maps content, production analytics and provider behavior were not verified. Local HTML link/asset targets and heading anchors, JavaScript syntax and `git diff --check` passed.
