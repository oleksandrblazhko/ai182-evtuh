1. Заповніть таблицю БД ще трьома рядками.  
   ![11](https://user-images.githubusercontent.com/56599282/209475150-8e43317b-06da-4b90-91ac-19a6165654de.png)
   
   ![12](https://user-images.githubusercontent.com/56599282/209475152-726d2584-06a0-4f61-84ef-bd3f0da4487e.png)
2. Створіть схему даних користувача та віртуальну таблицю у цій схемі з правилами вибіркового керування доступом для
   користувача так, щоб він міг побачити тільки один з рядків таблиці з урахуванням одного значення її останньої
   колонки.  
   _Створимо умову, за якою користувач, що має роль `yevtukh` зможе переглядати робітників, в яких заробітня плата не
   менша за 320_  
   ```sql
   create table role2employer
   (
   role_name varchar,
   salary    integer
   );
   insert into role2employer
   values ('yevtukh', 320);
   grant select on employer to yevtukh;
   grant select on role2employer to yevtukh;
   
   create schema yevtukh;
   alter schema yevtukh owner to yevtukh;

   create or replace view current_user_roles as
   with recursive cur_user_id as (select oid
                                  from pg_roles
                                  where rolname = current_user
                                  union all
                                  select m.roleid
                                  from cur_user_id
                                      join pg_auth_members m on m.member = cur_user_id.oid)
   select oid::regrole::text as rolename
   from cur_user_id;
   create or replace view yevtukh.employer as
   select u.*
   from public.employer u,
        role2employer ru
   where ru.role_name in (select * from current_user_roles)
     and ru.salary <= u.salary;
   
   grant select on yevtukh.employer to yevtukh;
   revoke select on public.employer from yevtukh;
   ```  
   ![13](https://user-images.githubusercontent.com/56599282/209475165-ff58d42c-e9f3-4c72-9c72-00c72804a980.png)
3. Перевірте роботу механізму вибіркового керування, виконавши операції SELECT, INSERT, UPDATE, DELETE.
   ```sql
   select * from yevtukh.employer;
   ```  
   ![14](https://user-images.githubusercontent.com/56599282/209475180-361fd12b-2fb3-4999-93a0-de7eedfeb877.png)
   ```sql
   insert into yevtukh.employer
   values (6, 'Sidorenko', 350);
   ```
   ![15](https://user-images.githubusercontent.com/56599282/209475184-810985bf-d8e5-451e-b3ca-9e0e4c1ed85e.png)
   ```sql
   update yevtukh.employer u set name='Sidorenkov' where name='Sidorenko';
   ```
   ![16](https://user-images.githubusercontent.com/56599282/209475193-97a89bdc-cc14-41b8-8ce6-cda70252a58d.png)
   ```sql
   delete from yevtukh.employer;
   ```
   ![17](https://user-images.githubusercontent.com/56599282/209475195-154410a5-72ed-4a01-8c3f-5c5aa3b3d95d.png)
