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


-- function that takes the incoming row data of an insert or update query
-- and inserts the id and email into the public.profiles table.
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

-- Trigger that needs the above function to exist. When a row is inerted or updated in the
-- auth.users table, this will call the function we defined above.
CREATE TRIGGER shadow_profiles
    AFTER INSERT OR UPDATE ON auth.users
    FOR EACH ROW EXECUTE PROCEDURE public.new_profiles();

-- backfill existing data
insert into public.profiles select id, email from auth.users;

-- get user with id who is not an employee
elect * from public.profiles p left join public.user_relationships ur on p.id = ur.employee_id
where p.id = 'f88eba36-fdec-42ab-baea-993fcc7777df' and ur.employee_id is null;

-- get user and see whether they have anything in the user relationships table
elect * from public.profiles p left join public.user_relationships ur on p.id = ur.employee_id
where p.id = 'f88eba36-fdec-42ab-baea-993fcc7777df';-- and ur.employee_id is null;