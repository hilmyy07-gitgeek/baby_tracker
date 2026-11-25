# Catatan Bayi (Supabase + Vercel)

Situs statis (tanpa build). Data disimpan di Supabase, tampilan di-host di Vercel.

## 1. Siapkan Supabase
1. Buat project baru di supabase.com.
2. SQL Editor -> New query -> tempel isi `schema.sql` -> Run.
3. Authentication -> Users -> **Add user** (buat 2 akun: ayah dan ibu, centang auto-confirm).
4. Setelah kedua akun dibuat, matikan pendaftaran umum: Authentication -> Sign In / Providers
   -> matikan **Allow new users to sign up** (nama menu bisa sedikit berbeda).
5. Project Settings -> API: salin **Project URL** dan **anon / publishable key**.

## 2. Isi konfigurasi
Edit `config.js`, ganti `ISI_PROJECT_URL` dan `ISI_ANON_KEY`.
Key anon memang publik; data aman karena Row Level Security di `schema.sql`.
Jangan pernah memasukkan service_role key.

## 3. Coba di komputer (opsional)
    python3 -m http.server 8000   # lalu buka http://localhost:8000

## 4. Deploy ke Vercel
1. Upload folder ini ke repositori GitHub.
2. vercel.com -> Add New -> Project -> import repositori.
3. Framework Preset: **Other**. Kosongkan Build Command dan Output Directory. Klik Deploy.

## 5. Pakai di HP
Buka alamat Vercel di HP ayah dan ibu, login, lalu "Tambahkan ke Layar Utama".

## Catatan
- Pencatatan butuh internet (belum ada antrean offline).
- Zona waktu mengikuti HP; waktu disimpan dalam UTC di database.
- Backup: ekspor CSV rutin, atau gunakan fitur backup Supabase.
