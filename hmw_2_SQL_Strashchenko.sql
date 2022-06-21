--Создать таблицу salary
create table salary (
id serial primary key,
monthly_salary int not null
);

--Создать таблицу roles
create table roles (
id serial primary key,
role_title varchar (50) unique not null
);

--Создать таблицу roles_salary
create table roles_salary (
id serial primary key,
id_role int not null,
id_salary int not null,
foreign key (id_role)
	references roles(id),
foreign key (id_salary)
	references salary(id)	
);

--Заполнить таблицу salary
insert into salary (monthly_salary)
values(2000),
	  (1000),
	  (1200),
	  (1300),
	  (2400),
	  (1400),
	  (2800),
	  (2900),
	  (4500),
	  (1900),
	  (1100),
	  (3700);

--Вывести таблицу salary
select * 
from salary;

--Удалить таблицу salary;
drop table salary;

--Заполнить таблицу roles
insert into roles (role_title)
values('QA_manual_junior'),
	  ('QA_manual_middle'),
	  ('QA_manual_senior'),
	  ('QA_automation_junior'),
	  ('QA_automation_middle'),
	  ('QA_automation_senior'),
	  ('Java_developer_junior'),
	  ('Java_developer_middle'),
	  ('Java_developer_senior');
	 
--Заполнить таблицу roles_salary	 
insert into roles_salary(id_role, id_salary)
values (1,2),
	   (2,4),
	   (3,6),
	   (4,3),
	   (5,11),
	   (6,12),
	   (7,2),
	   (8,5),
	   (9,9);

--Добавить колонку parking в таблицу roles
alter table roles	
add column parking int;

--Присвоить значение 1 в колонке parking, если работник является senior
update roles 
set parking = 1
where role_title like '%senior';

--Переименовать колонку parking на taxi
alter table roles 
rename column parking to taxi;

--Удалить колонку taxi
alter table roles 
drop column taxi;

--Добавить значение с несуществующим id_salary
insert into roles_salary(id_role, id_salary)
values (1,15);

-- 1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select roles.role_title, salary.monthly_salary
from roles_salary 
inner join salary on roles_salary.id_salary = salary.id
inner join roles on roles_salary.id_role = roles.id ;

-- 2. Вывести всех работников у которых ЗП меньше 2000.
select roles.role_title, salary.monthly_salary
from roles_salary 
inner join salary on roles_salary.id_salary = salary.id
inner join roles on roles_salary.id_role = roles.id
where salary.monthly_salary < '2000';

-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select salary.monthly_salary
from salary
left join roles_salary on roles_salary.id_salary = salary.id
where roles_salary.id_salary is null;

-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select salary.monthly_salary
from salary
left join roles_salary on roles_salary.id_salary = salary.id
where roles_salary.id_salary is null and salary.monthly_salary <'2000';

-- 5. Найти всех работников кому не начислена ЗП.
-- 6. Вывести всех работников с названиями их должности.
-- 7. Вывести имена и должность только Java разработчиков.
-- 8. Вывести имена и должность только Python разработчиков.
-- 9. Вывести имена и должность всех QA инженеров.
-- 10. Вывести имена и должность ручных QA инженеров.
-- 11. Вывести имена и должность автоматизаторов QA
-- 12. Вывести имена и зарплаты Junior специалистов
-- 13. Вывести имена и зарплаты Middle специалистов
-- 14. Вывести имена и зарплаты Senior специалистов
-- 15. Вывести зарплаты Java разработчиков
-- 16. Вывести зарплаты Python разработчиков
-- 17. Вывести имена и зарплаты Junior Python разработчиков
-- 18. Вывести имена и зарплаты Middle JS разработчиков
-- 19. Вывести имена и зарплаты Senior Java разработчиков
-- 20. Вывести зарплаты Junior QA инженеров
-- 21. Вывести среднюю зарплату всех Junior специалистов
-- 22. Вывести сумму зарплат JS разработчиков
-- 23. Вывести минимальную ЗП QA инженеров
-- 24. Вывести максимальную ЗП QA инженеров
-- 25. Вывести количество QA инженеров
-- 26. Вывести количество Middle специалистов.
-- 27. Вывести количество разработчиков
-- 28. Вывести фонд (сумму) зарплаты разработчиков.
-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000