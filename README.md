# Lingoezy

A "did you get fooled?" translation quiz for [bgameworld.com](https://bgameworld.com). Pick the right translation from four real words that look alike. Some of them are false friends: *embarazada* looks like "embarrassed" but means pregnant.

- **Today's ten:** 10 words a day in Spanish, French, Brazilian Portuguese, German or Italian. Three of them are false-friend traps. Everyone gets the same set.
- **Practice:** endless random words.
- **Make a quiz:** write your own word and decoys and get a link to send to friends.
- Points, day streaks, a FOOLED / NOT FOOLED stamp with what every option really means, and result sharing to WhatsApp and X.

The whole game is `public/index.html`, with no build step.

## Deploy

It deploys as a Cloudflare Worker with static assets, the same as the other bgameworld games. `wrangler.jsonc` uploads only `public/`.

1. In Cloudflare, connect this repo to the `lingoezy` Worker (Workers & Pages → lingoezy → Settings → Build). Leave the build command empty; the deploy command is `npx wrangler deploy`. Every push to `main` then redeploys.
2. Add the custom domain `lingoezy.bgameworld.com`. Friend-quiz links and share text already point there.
3. In Google Search Console, submit `https://lingoezy.bgameworld.com/sitemap.xml`.

`LAUNCH_DATE` near the top of the script is the day that counts as No. 1 (set to 11 Oct 2026, the day it went on bgameworld.com).

`public/` also holds the SEO and home-screen files: `og-image.jpg` (share preview), favicons and app icons, `site.webmanifest`, `robots.txt` and `sitemap.xml`. The title, description, share cards and structured data are in the `<head>` of `public/index.html`.

## Crowd stats (optional)

1. Open Supabase, go to SQL editor, and run `supabase.sql`.
2. In `public/index.html`, set `SUPABASE_URL` and `SUPABASE_ANON_KEY` (Project Settings → API).

This shows "5,905 players have answered", the percentage bars on each answer, and "63% were fooled". Until it's set up, those numbers stay hidden. The game never makes them up.

## Editing words

- `VOCAB_RAW` has one line per word: `english|spanish|french|portuguese|german|italian`. Wrong answers are picked automatically from look-alike words in the same language, so adding words also improves the decoys. Keep one meaning per line, and don't add two English words that translate to the same word.
- `FALSE_FRIENDS` holds `[prompt, correct answer, trap, what the trap means]` for each language.

Have a native speaker look over each language before launch.
