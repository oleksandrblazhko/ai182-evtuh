create or replace function get_data_secure(employer_name varchar)
    returns table (e_id integer, name varchar, salary integer) as $$
declare
    query_str varchar;
begin
    query_str := 'select e_id, name, salary from employer where name = $1';
    raise notice 'Query: %', query_str;
    return query execute query_str using employer_name;
end;
$$ language plpgsql;
