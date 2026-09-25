-- Gündoğumu gerçek istatistikler + yorumlar + haber alanları

alter table public.news add column if not exists slug text;
alter table public.news add column if not exists excerpt text;
alter table public.news add column if not exists category text default 'Genel';
alter table public.news add column if not exists author text default 'Gündoğumu';
alter table public.news add column if not exists published boolean not null default true;

create table if not exists public.comments (
  id uuid primary key default gen_random_uuid(),
  news_id uuid references public.news(id) on delete cascade,
  name text not null,
  content text not null,
  approved boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.site_visits (
  id uuid primary key default gen_random_uuid(),
  path text,
  visited_at timestamptz not null default now()
);

alter table public.comments enable row level security;
alter table public.site_visits enable row level security;

-- Herkes yalnızca onaylanmış yorumları okuyabilir.
drop policy if exists "Herkes onaylı yorumları görebilir" on public.comments;
create policy "Herkes onaylı yorumları görebilir"
on public.comments for select to anon, authenticated
using (approved = true);

-- Admin panelinin tüm yorumları görebilmesi.
drop policy if exists "Admin tüm yorumları görebilir" on public.comments;
create policy "Admin tüm yorumları görebilir"
on public.comments for select to authenticated
using (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

-- Ziyaretçiler yorum gönderebilir; yorum ilk olarak onaysız gelir.
drop policy if exists "Herkes yorum gönderebilir" on public.comments;
create policy "Herkes yorum gönderebilir"
on public.comments for insert to anon, authenticated
with check (approved = false);

-- Yalnızca admin yorum onaylayabilir/silebilir.
drop policy if exists "Admin yorum güncelleyebilir" on public.comments;
create policy "Admin yorum güncelleyebilir"
on public.comments for update to authenticated
using (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
))
with check (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

drop policy if exists "Admin yorum silebilir" on public.comments;
create policy "Admin yorum silebilir"
on public.comments for delete to authenticated
using (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

-- Ziyaret kaydı oluşturmak herkese açık; kayıtları yalnızca admin okuyabilir.
drop policy if exists "Herkes ziyaret kaydedebilir" on public.site_visits;
create policy "Herkes ziyaret kaydedebilir"
on public.site_visits for insert to anon, authenticated
with check (true);

drop policy if exists "Admin ziyaretleri görebilir" on public.site_visits;
create policy "Admin ziyaretleri görebilir"
on public.site_visits for select to authenticated
using (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

-- Admin haberleri düzenleyebilsin.
drop policy if exists "Admin haber ekleyebilir" on public.news;
create policy "Admin haber ekleyebilir"
on public.news for insert to authenticated
with check (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

drop policy if exists "Admin haber güncelleyebilir" on public.news;
create policy "Admin haber güncelleyebilir"
on public.news for update to authenticated
using (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
))
with check (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
));

drop policy if exists "Admin haber silebilir" on public.news;
create policy "Admin haber silebilir"
on public.news for delete to authenticated
using (exists (
  select 1 from public.profiles p
  where p.id = auth.uid() and p.role = 'admin'
));
