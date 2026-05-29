-- Actualización: permitir nombres repetidos (tocayos) + visibilidad en Cambios.
-- Correr 1 vez en el SQL Editor de Supabase (proyecto del álbum).

-- 1) permitir que llegue otro "Pedro": quitar el índice único por nombre
drop index if exists wc2026_players_name_uniq;

-- 2) aparecer o no en el espacio de Cambios (oculto por default)
alter table public.wc2026_players
  add column if not exists share boolean not null default false;
