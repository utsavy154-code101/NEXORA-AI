# NEXORA AI — full-stack foundation

Mobile-first Next.js + Supabase Auth/database + server-side OpenAI route.

## Run
1. Install Node.js 20+ and run `npm install`.
2. Copy `.env.example` to `.env.local`, fill Supabase URL + anon key and server-only OpenAI API key.
3. In Supabase SQL Editor, run `supabase/schema.sql`.
4. Run `npm run dev`, open the local URL.

## Deploy
Push project to a private GitHub repository, import it in Vercel, set the same environment variables in Vercel project settings, deploy.

## Security notes
- OpenAI key is server-only; never put it in `NEXT_PUBLIC_*`.
- Database tables use RLS owner policies.
- Vault schema stores ciphertext and nonce only. Actual client-side encryption/decryption UI and key recovery flow must be implemented and security-reviewed before storing real secrets.
- This is a foundation, not a fully audited production service. Add rate limiting, abuse controls, email confirmation, password reset, CSP, logging without sensitive payloads, and security review before public launch.
