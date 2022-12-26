![1](https://user-images.githubusercontent.com/56599282/209482831-dc30e60a-3690-4749-a21e-be6351bbeea7.png)

![2](https://user-images.githubusercontent.com/56599282/209482832-66057f66-284e-49c6-8c75-f11392a31dfa.png)

![3](https://user-images.githubusercontent.com/56599282/209482833-6edeffc3-81a2-4d3d-9e3b-fc307638545c.png)

![4](https://user-images.githubusercontent.com/56599282/209482834-096a0ad8-fd81-44e8-b549-7820f8f5a274.png)

![4_1](https://user-images.githubusercontent.com/56599282/209482837-dfe89fc8-673b-4fc3-a5f3-6ca6f6e50914.png)

![5](https://user-images.githubusercontent.com/56599282/209482839-b540ab76-8c64-49b6-af95-12f85afe1586.png)


_Змінити дані з обраним ім'ям неможливо через обмеження накладені у функції. Ім'я Sidorov не було замінено на Test Name._

<hr>

```sql
select *
from change_data('Sidorov'' or spot_conf>0 --', 'Test Name');
```  
_Через особливість запиту на кількість знайдених записів результат функції залишися рівним нулеві:_  
![6](https://user-images.githubusercontent.com/56599282/209482845-c497d9ba-f421-4a82-974b-ea6ff9f17f84.png)

_Проте, порушення цілісності даних відбулося:_  
![7](https://user-images.githubusercontent.com/56599282/209482850-864176eb-7632-4c30-a528-a317e463a64a.png)

_Усі записи таблиці отримали назву задану зловмисником._

