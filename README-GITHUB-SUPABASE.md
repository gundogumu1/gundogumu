# Gündoğumu — GitHub Pages + Supabase

1. `supabase-config.js` içindeki `SUPABASE_URL` ve `SUPABASE_ANON_KEY` değerlerini Supabase Dashboard > Project Settings > API bölümünden doldur.
2. Bu dosyayı GitHub Pages'e yükle.
3. Supabase Auth'ta oluşturduğun admin kullanıcıyla `login.html` üzerinden giriş yap.
4. Admin rolü `public.profiles.role = 'admin'` olmalı.

Not: `SUPABASE_ANON_KEY` / publishable key tarayıcıda kullanılmak üzere tasarlanmıştır. `service_role` anahtarını asla GitHub'a koyma.
