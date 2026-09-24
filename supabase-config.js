// Supabase bağlantı ayarları
// Bu dosyadaki iki değeri Supabase Dashboard > Project Settings > API bölümünden doldur.
window.SUPABASE_URL = 'https://eixwerzpzlmvimighjde.supabase.co';
window.SUPABASE_ANON_KEY = 'sb_publishable_a4NvrkASJcUw6Vzb3I-QvA_J3I4QnnE';

if (!window.SUPABASE_URL.includes('PROJE-REF') && !window.SUPABASE_ANON_KEY.includes('BURAYA_')) {
  window.supabaseClient = window.supabase.createClient(window.SUPABASE_URL, window.SUPABASE_ANON_KEY);
}
