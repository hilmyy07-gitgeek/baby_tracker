-- Jalankan di Supabase: SQL Editor -> New query -> paste -> Run
create table public.activities (
  id uuid primary key default gen_random_uuid(),
  ts timestamptz not null default now(),   -- waktu kejadian (sampai detik)
  type text not null,                      -- susu, bak, bab, tidur, bangun, gumoh, obat, suhu, mandi
  detail text not null default '',
  minutes integer,                         -- durasi tidur (menit), terisi saat "bangun"
  by_name text not null default '',        -- Ayah / Ibu
  created_by uuid default auth.uid(),
  created_at timestamptz not null default now()
);
create index activities_ts_idx on public.activities (ts desc);

-- Keamanan: hanya akun yang sudah login (ayah dan ibu) yang boleh akses
alter table public.activities enable row level security;
create policy "keluarga baca"   on public.activities for select to authenticated using (true);
create policy "keluarga tambah" on public.activities for insert to authenticated with check (true);
create policy "keluarga ubah"   on public.activities for update to authenticated using (true) with check (true);
create policy "keluarga hapus"  on public.activities for delete to authenticated using (true);

-- Sinkronisasi real-time antar HP
alter publication supabase_realtime add table public.activities;
