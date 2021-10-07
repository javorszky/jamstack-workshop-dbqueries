-- create a table that relates users to users
create table public.user_relationships (
    manager_id uuid references public.profiles on delete cascade not null,
    employee_id uuid references public.profiles on delete cascade not null
);

-- this will mean we won't insert the same manager/employee pair more than once, and also speeds up lookup by manager (get all employees managed by X)
create unique index emp_man_idx on user_relationships(manager_id, employee_id);

-- this will help us with the reverse query: get the manager of employee
create index employee_idx on user_relationships(employee_id);

-- if we want to also return the manager from the index itself rather than reading from the table, we can do a covering index
create unique index employee_covering_idx on user_relationships(employee_id) include (manager_id);

-- right now each employee can have many different managers... if we want to fix that, the easiest way to solve that is to add a unique index on the employee column itself. The only time an employee would show up twice in the column is if they had a different manager (see previous unique composite index)
create unique index one_employee_idx on user_relationships(employee_id);

-- this will make sure that I can't insert the same uuid for both manager and employee - a person can't be their own manager
alter table user_relationships add check (manager_id <> employee_id);

-- these two will make sure that if a user is an employee, they cannot also have managerial roles here
create or replace function employee_no_manager()
  returns trigger
  language plpgsql
  as
  $$
  begin
    if exists (select employee_id from user_relationships where employee_id = new.manager_id) then
      raise exception 'An employee cannot also be a manager';
    end if;
    return new;
  end;
  $$;


CREATE TRIGGER employee_no_manager_trigger
    BEFORE INSERT OR UPDATE ON user_relationships
    FOR EACH ROW EXECUTE PROCEDURE employee_no_manager();

-- drop trigger employee_no_manager_trigger on user_relationships;
-- drop function public.employee_no_manager;

-- this one creates a faux relationship.
insert into user_relationships (manager_id, employee_id) values ('f88eba36-fdec-42ab-baea-993fcc7777df', '5995b4db-e19f-4f7c-9e55-10151b8a678a');


-- this one creates a function that we can then call with await supabase.rpc('public.is_employee', {uid: uid})
create or replace function public.is_employee(uid uuid)
returns boolean
language plpgsql
as
$$
declare
   is_employee boolean;
begin
    select exists(
      select
      from public.profiles p
      left join public.user_relationships ur
      on p.id = ur.employee_id
      where p.id = uid
      and ur.employee_id is not null
    ) into is_employee;

    return is_employee;
end;
$$;