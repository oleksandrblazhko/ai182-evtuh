```sql
select * from employer;

select * from change_data_secure('Test Name'' or spot_conf>0 --', 'Sidorov');

select * from employer;
```  

![4](https://user-images.githubusercontent.com/56599282/209483129-cdb8102b-ab29-407b-ba4f-5c4be821e8e6.png)

![1](https://user-images.githubusercontent.com/56599282/209483130-15e64cc3-8c97-4171-84f3-e3de1dcc1fa4.png)

![2](https://user-images.githubusercontent.com/56599282/209483131-578941e1-998b-4efb-8f77-6540fdaeb62f.png)

![3](https://user-images.githubusercontent.com/56599282/209483136-9887a1f3-6aab-44f2-a38c-5bd82fec5cb3.png)

_Як видно, змінити дані не вдалося._

<hr>

```sql
select * from get_data_secure('any'' or 1=1 -- ');
```  

![5](https://user-images.githubusercontent.com/56599282/209483146-cef5a30f-3a5a-4920-b2c2-24996eec171b.png)

_Видно, що отримати усі записи не вдалося_

_Для порівняння виконаємо ще раз запит без захисту від ін'єкцій:_

```sql
select * from get_data('any'' or 1=1 -- ');
```  

![6](https://user-images.githubusercontent.com/56599282/209483148-b1da4f88-6cb1-44a0-a6fd-e005fc6638db.png)

_(звернення до функції, що не має захисту)_
