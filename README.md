# Lingoezy

A "did you get fooled?" translation quiz for [bgameworld.com](https://bgameworld.com). Pick the right translation from four real words that look alike. Some of them are false friends: *embarazada* looks like "embarrassed" but means pregnant.

- **Today's ten:** 10 words a day in Spanish, French, Brazilian Portuguese, German or Italian. Three of them are false-friend traps. Everyone gets the same set.
- **Practice:** endless random words.
- **Make a quiz:** write your own word and decoys and get a link to send to friends.
- Points, day streaks, a FOOLED / NOT FOOLED stamp with what every option really means, and result sharing to WhatsApp and X.

The whole game is `index.html`, with no build step.

## Deploy

Connect this repo to Cloudflare Pages (no build command, output directory `/`) and add the custom domain `lingoezy.bgameworld.com`. Friend-quiz links and share text already point there.

Set `LAUNCH_DATE` near the top of the script to your launch day.

## Crowd stats (optional)

1. Open Supabase, go to SQL editor, and run `supabase.sql`.
2. In `index.html`, set `SUPABASE_URL` and `SUPABASE_ANON_KEY` (Project Settings → API).

This shows "5,905 players have answered", the percentage bars on each answer, and "63% were fooled". Until it's set up, those numbers stay hidden. The game never makes them up.

## Editing words

- `VOCAB_RAW` has one line per word: `english|spanish|french|portuguese|german|italian`. Wrong answers are picked automatically from look-alike words in the same language, so adding words also improves the decoys. Keep one meaning per line, and don't add two English words that translate to the same word.
- `FALSE_FRIENDS` holds `[prompt, correct answer, trap, what the trap means]` for each language.

Have a native speaker look over each language before launch.
