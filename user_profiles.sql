-- Create a table for Public Profiles
create table profiles (
  id uuid references auth.users not null,
  email text unique not null,
  updated_at timestamp with time zone default current_timestamp,
  username text unique,

  primary key (id),
  unique(username),
  constraint username_length check (char_length(username) >= 3)
);

create or replace function public.new_profiles()
  returns trigger
  language plpgsql
  security definer
  as
  $$
  begin
    insert into
      public.profiles (id, email)
    values
      (new.id, new.email)
    on conflict
      set updated_at = current_timestamp;
    return new;
  end;
  $$;


CREATE TRIGGER shadow_profiles
    AFTER INSERT OR UPDATE ON auth.users
    FOR EACH ROW EXECUTE PROCEDURE public.new_profiles();