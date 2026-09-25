// Supabase bağlantı ayarları
window.SUPABASE_URL = 'https://lhldwocsordiliyfevda.supabase.co';
window.SUPABASE_ANON_KEY = 'sb_publishable_2HqDsPELw6IJfnWDDemwXA_seNEV9iW';

if (
  !window.SUPABASE_URL.includes('PROJE-REF') &&
  !window.SUPABASE_ANON_KEY.includes('BURAYA_')
) {
  window.supabaseClient = window.supabase.createClient(
    window.SUPABASE_URL,
    window.SUPABASE_ANON_KEY
  );
}