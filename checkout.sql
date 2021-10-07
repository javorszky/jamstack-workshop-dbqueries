create table orders (
    id uuid primary key not null default uuid_generate_v4(),
    user_id uuid not null references public.profiles(id) on delete set null,
    shipping_address uuid not null references public.addresses(id),
    billing_address uuid not null references public.addresses(id),
    cart_items jsonb not null default '{}'::jsonb,
    total decimal
)