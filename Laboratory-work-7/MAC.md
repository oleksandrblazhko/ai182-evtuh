1. Створіть у БД структури даних, необхідні для роботи повноважного керування доступом.

    ```sql
    drop table if exists access_levels cascade;
    create table access_levels
    (
    access_level_id integer primary key,
    access_level    varchar unique
    );
    insert into access_levels
    values (1, 'public'),
           (2, 'private'),
           (3, 'secret'),
           (4, 'topsecret');
    drop table if exists role_access_level cascade;
    create table role_access_level
    (
    role_name    varchar primary key,
    access_level integer references access_levels (access_level_id)
    );
    revoke all on role_access_level from group yevtukh;
    grant select on role_access_level to group yevtukh;
    ```  
   ![18](https://user-images.githubusercontent.com/56599282/209476046-5d8c9090-bf5a-4891-ac53-61cfee74eb40.png)

2. Визначте для кожного рядка таблиці мітки конфіденційності (для кожного рядка свою мітку).
   ```sql
   alter table employer
   add column spot_conf integer default 3
   references access_levels (access_level_id);
   
   update public.employer
   set spot_conf = 2;
   update public.employer
   set spot_conf = 3
   where e_id <= 4;
   ```
   ![19](https://user-images.githubusercontent.com/56599282/209476077-e97d4abe-99f9-4838-9b1a-625882d7ad7e.png)
   ![20](https://user-images.githubusercontent.com/56599282/209476069-d2663501-2cca-43cf-8cbd-c51b94250bbb.png)
   
3. Визначте для користувача його рівень доступу
   ```sql
   insert into role_access_level
   values ('yevtukh', 2);
   ```
4. Створіть нову схему даних.
   ```sql
   drop schema if exists yevtukh cascade;
   create schema yevtukh;
   alter schema yevtukh owner to yevtukh;
   ```  
   ![21](https://user-images.githubusercontent.com/56599282/209476086-739a3ba8-9c2e-44f7-bf0e-f46f36138fb1.png)
5. Створіть віртуальну таблицю, назва якої співпадає з назвою реальної таблиці та яка забезпечує SELECT-правила
   повноважного керування доступом для користувача.  
   ```sql
   drop view if exists yevtukh.employer;
   create view yevtukh.employer as
   select e_id, name, salary
   from public.employer u,
        role_access_level ral
   where ral.role_name in (select * from current_user_roles)
     and ral.access_level >= u.spot_conf;
   
   revoke all on public.employer from yevtukh;
   
   grant select, insert, update, delete
    on yevtukh.employer
    to yevtukh;
   ```  
   ![22](https://user-images.githubusercontent.com/56599282/209476094-10d5a543-662a-46af-a70d-0fcf0924348d.png)
6. Створіть INSERT/UPDATE/DELETE-правила повноважного керування доступом для користувача.  
   ```sql
   create or replace rule employer_insert as
       on insert to yevtukh.employer
       do instead
       insert into public.employer
   select new.e_id, new.name, new.salary, ral.access_level
   from role_access_level ral
   where ral.role_name in (select * from current_user_roles);
   
   create or replace rule employer_update as
       on update to yevtukh.employer
                    do instead
   update public.employer
   set e_id=new.e_id,
       name=new.name,
       salary=new.salary,
       spot_conf=ral.access_level
      from role_access_level ral
   where ral.role_name in (select * from current_user_roles) and e_id=old.e_id;
   
   create or replace rule employer_delete as
       on delete to yevtukh.employer
       do instead
   delete
   from public.employer
   where e_id = old.e_id;
   ```  
   ![23](https://user-images.githubusercontent.com/56599282/209476101-2ffe716e-9975-4763-a704-38ad7b38f9fd.png)
7. Перевірте роботу механізму повноважного керування, виконавши операції SELECT, INSERT, UPDATE, DELETE  
   ![24](https://user-images.githubusercontent.com/56599282/209476104-0c325cd8-99c4-46fa-93b8-cb521e58888c.png)
   ![27](https://user-images.githubusercontent.com/56599282/209476106-afc187f5-bbef-4854-8483-5174a13ffa4a.png)
   ![25](https://user-images.githubusercontent.com/56599282/209476107-50d112dd-9ced-4dac-805d-e747227ab09e.png)
   ![28](https://user-images.githubusercontent.com/56599282/209476109-c7b5e516-7381-4827-b657-af83fca1c084.png)
   ![26](https://user-images.githubusercontent.com/56599282/209476113-fbf92c1a-ec5d-4fb5-b83a-b14c22e3c4f6.png)
   ![29](https://user-images.githubusercontent.com/56599282/209476116-0553ef30-16cb-43df-923b-c4b8899a6c2a.png)

*_Запити `select` виконувалися від користувача postgres_
