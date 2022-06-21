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
alter table employee_names 
rename column employee_name to name;

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
select roles_salary.id_role, roles.role_title 
from roles 
left join roles_salary on roles_salary.id_role  = roles.id 
where roles_salary.id_role is null;

-- 6. Вывести всех работников с названиями их должности.
drop table employee_names;

create table employee_names (
id_employee serial primary key,
id_role int not null,
name varchar (50) not null,
foreign key (id_role)
	references roles(id)
);

select * from employee_names;

insert into employee_names(id_role,name)
values (1,'Ivan'),
	   (1,'Arina'),
	   (2,'Anna'),
	   (3,'Elena'),
	   (4,'Vladislav'),
	   (4,'Evgeny'),
	   (5,'Vadim'),
	   (6,'Maxim'),
	   (7,'Oleg'),
	   (8,'Irina'),
	   (8,'Anatoly'),
	   (9,'Angrej');

select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id ;

-- 7. Вывести имена и должность только Java разработчиков.
select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id 
where roles.role_title like '%Java%';

-- 8. Вывести имена и должность только Python разработчиков.
insert into roles (role_title)
values ('Python_developer_junior'),
	  ('Python_developer_middle'),
	  ('Python_developer_senior');

select * from roles;	

insert into employee_names(id_role, name)
values (10,'Aleksandr'),
	   (11,'Inna'),
	   (12,'Vladimir'),
	   (12,'Pavel');
	  
select * from employee_names;
	  
select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id 
where roles.role_title like '%Python%';

-- 9. Вывести имена и должность всех QA инженеров.
select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id 
where roles.role_title like '%QA%';

-- 10. Вывести имена и должность ручных QA инженеров.
select employee_names.name, roles.role_title, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join 
where roles.role_title like '%manual%';

-- 11. Вывести имена и должность автоматизаторов QA
select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id 
where roles.role_title like '%automation%';

-- 12. Вывести имена и зарплаты Junior специалистов
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%junior%';

-- 13. Вывести имена и зарплаты Middle специалистов
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%middle%';

-- 14. Вывести имена и зарплаты Senior специалистов
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%senior%';

-- 15. Вывести зарплаты Java разработчиков
select salary.monthly_salary  
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Java%';

-- 16. Вывести зарплаты Python разработчиков
select salary.monthly_salary  
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id  
where roles.role_title like '%Python%';

-- 17. Вывести имена и зарплаты Junior Python разработчиков
insert into roles_salary(id_role, id_salary)
values (10,11),
	   (11,12),
	   (12,9);
	  
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Python%' and roles.role_title like '%junior%';

-- 18. Вывести имена и зарплаты Middle JS разработчиков
insert into roles (role_title)
values ('JS_developer_junior'),
	   ('JS_developer_middle'),
	   ('JS_developer_senior');

select * from roles;	

insert into employee_names(id_role, name)
values (13,'Arina'),
	   (13,'Vadim'),
	   (14,'Andrej'),
	   (15,'Elena');
	  
insert into roles_salary(id_role, id_salary)
values (13,11),
	   (14,12),
	   (15,9);
	  
select * from employee_names;

select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%JS%' and roles.role_title like '%middle%';

-- 19. Вывести имена и зарплаты Senior Java разработчиков
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Java%' and roles.role_title like '%senior%';

-- 20. Вывести зарплаты Junior QA инженеров
select salary.monthly_salary  
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%QA%' and roles.role_title like '%junior%';

-- 21. Вывести среднюю зарплату всех Junior специалистов
select avg(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%junior%';

-- 22. Вывести сумму зарплат JS разработчиков
select sum(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%JS%';

-- 23. Вывести минимальную ЗП QA инженеров
select min(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%QA%';

-- 24. Вывести максимальную ЗП QA инженеров
select max(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%QA%';

-- 25. Вывести количество QA инженеров
select count(employee_names.name)
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
where roles.role_title like '%QA%';

-- 26. Вывести количество Middle специалистов.
select count(employee_names.name)
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
where roles.role_title like '%middle%';

-- 27. Вывести количество разработчиков
select count(employee_names.name)
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
where roles.role_title like '%developer%';

-- 28. Вывести фонд (сумму) зарплаты разработчиков.
select sum(salary.monthly_salary)
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%developer%';

-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000