CREATE TYPE addressType AS ENUM ('shipping', 'billing');


create table addresses (
    id uuid primary key not null,
    user_id uuid references profiles.id on delete cascade not null,
    type addressType,
    address1 text,
    address2 text,
    city text,
    state text,
    country text
)

create index shipping_idx on addresses (type) where type = 'shipping';