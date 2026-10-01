-- Run in Supabase SQL Editor. Row Level Security is enabled on every user-owned table.
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  created_at timestamptz not null default now()
);
create table if not exists public.notes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null default '',
  ciphertext text not null,
  nonce text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  completed boolean not null default false,
  created_at timestamptz not null default now()
);
create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  description text not null default '',
  created_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
alter table public.notes enable row level security;
alter table public.tasks enable row level security;
alter table public.projects enable row level security;
create policy "profile owner only" on public.profiles for all using (auth.uid() = id) with check (auth.uid() = id);
create policy "notes owner only" on public.notes for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "tasks owner only" on public.tasks for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "projects owner only" on public.projects for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
