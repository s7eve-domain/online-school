# SwidHub: Building Skills. Creating Opportunities.
A static prototype of the full platform. Open `index.html` in a browser, or upload the folder to any static host (Vercel, Netlify, GitHub Pages).

| Page | What it covers |
|---|---|
| index.html | Homepage, course catalog with filters, mentor preview, contact (stevensrealm.net@gmail.com, 08143764067) |
| learn.html | Sign up and log in, role selection, course detail, learning player, certificate, learner and instructor dashboards |
| mentors.html | Mentor directory, profiles, booking with timezone, chat, onboarding, mentor dashboard, matching quiz |
| checkout.html | Cart, coupons (WELCOME10, SWID20, NG5000), subscriptions, Stripe-style demo checkout, admin panel |

Pages share data through the browser's localStorage, so they must be opened from the same folder or host.

## What is a demo
Login, payments, chat, video calls, uploads, emails and admin access are simulated in the browser. Use the Stripe test card 4242 4242 4242 4242 only; never enter a real card.

## Building the production version
Suggested stack: Next.js + Tailwind, Node/Express (or Django), PostgreSQL, S3 or Cloudinary, WebSockets, Vercel.
1. `npx create-next-app@latest swidhub` and port each page into components.
2. Create a Postgres database and run `docs/schema.sql`.
3. Build the endpoints in `docs/API.md`.
4. Stripe: add Checkout sessions and a webhook; use Stripe Connect for mentor payouts (platform commission 40%). Check that Stripe supports your business country; Paystack or Flutterwave are alternatives for Nigeria.
5. Add email (Resend or SendGrid), Google OAuth, and Zoom or Google Meet links.
6. Add privacy policy, terms and cookie consent pages before launch.
