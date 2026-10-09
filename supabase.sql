-- Shared stats for Lingoezy (how everyone answered each question).
-- Run once in the Supabase SQL editor. The game calls these functions with the
-- public anon key; the table stays locked behind row level security.

-- ---------- Lingoezy: answer split per question ----------
create table if not exists public.lingo_answers (
  qid        text        not null check (char_length(qid) <= 60),
  client_id  uuid        not null,
  choice     text        not null check (char_length(choice) <= 60),
  correct    boolean     not null,
  created_at timestamptz not null default now(),
  primary key (qid, client_id)
);
alter table public.lingo_answers enable row level security;

-- Record a player's first answer to a question and return how everyone answered.
create or replace function public.lingo_record_answer(
  p_qid text, p_client uuid, p_choice text, p_correct boolean
) returns table (opt text, votes bigint)
language plpgsql security definer set search_path = public as $$
begin
  if p_qid !~ '^(es|fr|pt|de|it):\d{4}-\d{2}-\d{2}:\d{1,2}$' and p_qid !~ '^c:\d+$' then
    raise exception 'bad question id';
  end if;
  insert into lingo_answers (qid, client_id, choice, correct)
  values (p_qid, p_client, left(p_choice, 60), p_correct)
  on conflict (qid, client_id) do nothing;
  return query
    select a.choice, count(*)::bigint from lingo_answers a where a.qid = p_qid group by a.choice;
end $$;

-- How many players have answered each question (shown before you answer).
create or replace function public.lingo_totals(p_qids text[])
returns table (qid text, total bigint)
language sql stable security definer set search_path = public as $$
  select a.qid, count(*)::bigint from lingo_answers a
  where a.qid = any (p_qids[1:20]) group by a.qid;
$$;

-- Only the anon/authenticated roles may call the functions; the table stays private.
revoke all on public.lingo_answers from anon, authenticated;
grant execute on function public.lingo_record_answer(text, uuid, text, boolean) to anon, authenticated;
grant execute on function public.lingo_totals(text[]) to anon, authenticated;
