-- Get the available column names by selecting one record and reading the column names
select * from information_schema.columns limit 1;

-- Get useful info on the structure of a table and its columns.
SELECT
  table_name,
  column_default,
  is_nullable,
  character_maximum_length,
  column_name,
  table_schema,
  data_type
FROM
  information_schema.columns
WHERE
  table_name = 'users';