
alter table profiles enable row level security;

create policy "Public profiles are viewable by everyone."
  on public.profiles for select
  using ( true );

create policy "Only the admin, or admin defined function can insert data."
  on public.profiles for insert
  with check ( current_user = 'supabase_admin' );

create policy "Users can update own profile."
  on public.profiles for update
  using ( auth.uid() = id );