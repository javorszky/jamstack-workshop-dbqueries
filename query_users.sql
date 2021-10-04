-- get the entire contents of the user relationships table
select * from user_relationships;

-- get all the rows from the user relationships table where the user with id is an employee (max of 1, or nothing)
select * from user_relationships where employee_id = 'f88eba36-fdec-42ab-baea-993fcc7777df';

-- get all the rows from the user relationships table where the user with id is a manager, and also return the employees' ids
select * from user_relationships where manager_id = '5995b4db-e19f-4f7c-9e55-10151b8a678a';

-- insert a manager / employee relationship.
insert into user_relationships (manager_id, employee_id) values ('5995b4db-e19f-4f7c-9e55-10151b8a678a', 'f88eba36-fdec-42ab-baea-993fcc7777df');

-- let's get the ids of all the employees from the auth table using this pivot table where the manager is the user with this id
select u.email, ur.employee_id from public.user_relationships ur left join auth.users u on u.id = ur.employee_id where ur.manager_id = '5995b4db-e19f-4f7c-9e55-10151b8a678a';