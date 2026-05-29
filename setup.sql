-- Tabla de jugadores del Álbum Mundial 26 (correr 1 vez en el SQL Editor de Supabase)
create extension if not exists pgcrypto;

create table if not exists public.wc2026_players (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  pin         text,
  color       text,
  have        jsonb not null default '{}'::jsonb,
  rep         jsonb not null default '{}'::jsonb,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

-- nombre único sin importar mayúsculas
create unique index if not exists wc2026_players_name_uniq on public.wc2026_players (lower(name));

alter table public.wc2026_players enable row level security;

-- App casual entre amigos, datos no sensibles (qué estampas tienes).
-- El PIN se valida en el cliente; estas políticas permiten leer/crear/actualizar con la anon key.
drop policy if exists wc_read on public.wc2026_players;
drop policy if exists wc_insert on public.wc2026_players;
drop policy if exists wc_update on public.wc2026_players;
create policy wc_read   on public.wc2026_players for select using (true);
create policy wc_insert on public.wc2026_players for insert with check (true);
create policy wc_update on public.wc2026_players for update using (true) with check (true);

grant select, insert, update on public.wc2026_players to anon, authenticated;
