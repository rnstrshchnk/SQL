--������� ������� salary
create table salary (
id serial primary key,
monthly_salary int not null
);

--������� ������� roles
create table roles (
id serial primary key,
role_title varchar (50) unique not null
);

--������� ������� roles_salary
create table roles_salary (
id serial primary key,
id_role int not null,
id_salary int not null,
foreign key (id_role)
	references roles(id),
foreign key (id_salary)
	references salary(id)	
);

--��������� ������� salary
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

--������� ������� salary
select * 
from salary;

--������� ������� salary;
drop table salary;

--��������� ������� roles
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
	 
--��������� ������� roles_salary	 
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

--�������� ������� parking � ������� roles
alter table roles	
add column parking int;

--��������� �������� 1 � ������� parking, ���� �������� �������� senior
update roles 
set parking = 1
where role_title like '%senior';

--������������� ������� parking �� taxi
alter table employees_names 
rename column name to employee_name;

select * from employees_names;

--������� ������� taxi
alter table roles 
drop column taxi;

--�������� �������� � �������������� id_salary
insert into roles_salary(id_role, id_salary)
values (1,15);

--������������� �������
alter table employee_names rename to employees_names;

-- 1. ������� ���� ���������� ��� �������� ���� � ����, ������ � ����������.
select roles.role_title, salary.monthly_salary
from roles_salary 
inner join salary on roles_salary.id_salary = salary.id
inner join roles on roles_salary.id_role = roles.id ;

-- 2. ������� ���� ���������� � ������� �� ������ 2000.
select roles.role_title, salary.monthly_salary
from roles_salary 
inner join salary on roles_salary.id_salary = salary.id
inner join roles on roles_salary.id_role = roles.id
where salary.monthly_salary < '2000';

-- 3. ������� ��� ���������� �������, �� �������� �� ��� �� ��������. (�� ����, �� �� ������� ��� � ��������.)
select salary.monthly_salary
from salary
left join roles_salary on roles_salary.id_salary = salary.id
where roles_salary.id_salary is null;

-- 4. ������� ��� ���������� �������  ������ 2000 �� �������� �� ��� �� ��������. (�� ����, �� �� ������� ��� � ��������.)
select salary.monthly_salary
from salary
left join roles_salary on roles_salary.id_salary = salary.id
where roles_salary.id_salary is null and salary.monthly_salary <'2000';

-- 5. ����� ���� ���������� ���� �� ��������� ��.
select roles_salary.id_role, roles.role_title 
from roles 
left join roles_salary on roles_salary.id_role  = roles.id 
where roles_salary.id_role is null;

-- 6. ������� ���� ���������� � ���������� �� ���������.
drop table employees_names;

create table employees_names (
id_employee serial primary key,
id_role int not null,
employee_name varchar (50) not null,
foreign key (id_role)
	references roles(id)
);

select * from employees_names;

insert into employees_names(id_role,employee_name)
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

select employees_names.employee_name, roles.role_title 
from employees_names inner join roles on employees_names.id_role = roles.id ;

-- 7. ������� ����� � ��������� ������ Java �����employee_name����.
select employees_names.employee_name, roles.role_title 
from employees_names inner join roles on employees_names.id_role = roles.id 
where roles.role_title like '%Java%';

-- 8. ������� ����� � ��������� ������ Python �������������.
insert into roles (role_title)
values ('Python_developer_junior'),
	  ('Python_developer_middle'),
	  ('Python_developer_senior');

select * from roles;	

insert into employees_names(id_role, employee_name)
values (10,'Aleksandr'),
	   (11,'Inna'),
	   (12,'Vladimir'),
	   (12,'Pavel');
	  
select * from employees_names;
	  
select employees_names.employee_name, roles.role_title 
from employees_names inner join roles on employees_names.id_role = roles.id 
where roles.role_title like '%Python%';

-- 9. ������� ����� � ��������� ���� QA ���������.
select employees_names.employee_name, roles.role_title 
from employees_names inner join roles on employees_names.id_role = roles.id 
where roles.role_title like '%QA%';

-- 10. ������� ����� � ��������� ������ QA ���������.
select employees_names.employee_name, roles.role_title, salary.monthly_salary  
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join 
where roles.role_title like '%manual%';

-- 11. ������� ����� � ��������� ��������������� QA
select employees_names.employee_name, roles.role_title 
from employees_names inner join roles on employees_names.id_role = roles.id 
where roles.role_title like '%automation%';

-- 12. ������� ����� � �������� Junior ������������
select employees_names.employee_name, salary.monthly_salary  
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%junior%';

-- 13. ������� ����� � �������� Middle ������������
select employees_names.employee_name, salary.monthly_salary  
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%middle%';

-- 14. ������� ����� � �������� Senior ������������
select employees_names.employee_name, salary.monthly_salary  
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%senior%';

-- 15. ������� �������� Java �������������
select salary.monthly_salary  
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Java%';

-- 16. ������� �������� Python �������������
select salary.monthly_salary  
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id  
where roles.role_title like '%Python%';

-- 17. ������� ����� � �������� Junior Python �������������
insert into roles_salary(id_role, id_salary)
values (10,11),
	   (11,12),
	   (12,9);
	  
select employees_names.employee_name, salary.monthly_salary  
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Python%' and roles.role_title like '%junior%';

-- 18. ������� ����� � �������� Middle JS �������������
insert into roles (role_title)
values ('JS_developer_junior'),
	   ('JS_developer_middle'),
	   ('JS_developer_senior');

select * from roles;	

insert into employees_names(id_role, employee_name)
values (13,'Arina'),
	   (13,'Vadim'),
	   (14,'Andrej'),
	   (15,'Elena');
	  
insert into roles_salary(id_role, id_salary)
values (13,11),
	   (14,12),
	   (15,9);
	  
select * from employees_names;

select employees_names.employee_name, salary.monthly_salary  
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%JS%' and roles.role_title like '%middle%';

-- 19. ������� ����� � �������� Senior Java �������������
select employees_names.employee_name, salary.monthly_salary  
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Java%' and roles.role_title like '%senior%';

-- 20. ������� �������� Junior QA ���������
select salary.monthly_salary  
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%QA%' and roles.role_title like '%junior%';

-- 21. ������� ������� �������� ���� Junior ������������
select avg(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%junior%';

-- 22. ������� ����� ������� JS �������������
select sum(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%JS%';

-- 23. ������� ����������� �� QA ���������
select min(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%QA%';

-- 24. ������� ������������ �� QA ���������
select max(salary.monthly_salary)
from roles 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%QA%';

-- 25. ������� ���������� QA ���������
select count(employees_names.employee_name)
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
where roles.role_title like '%QA%';

-- 26. ������� ���������� Middle ������������.
select count(employees_names.employee_name)
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
where roles.role_title like '%middle%';

-- 27. ������� ���������� �������������
select count(employees_names.employee_name)
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
where roles.role_title like '%developer%';

-- 28. ������� ���� (�����) �������� �������������.
select sum(salary.monthly_salary)
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%developer%';

-- 29. ������� �����, ��������� � �� ���� ������������ �� �����������
select employees_names.employee_name, roles.role_title, salary.monthly_salary
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
order by salary.monthly_salary asc;

-- 30. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� �� 1700 �� 2300
select employees_names.employee_name, roles.role_title, salary.monthly_salary
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where salary.monthly_salary between 1700 and 2300
order by salary.monthly_salary asc;

-- 31. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ������ 2300
select employees_names.employee_name, roles.role_title, salary.monthly_salary
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where salary.monthly_salary < '2300'
order by salary.monthly_salary asc;

-- 32. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ����� 1100, 1500, 2000
select employees_names.employee_name, roles.role_title, salary.monthly_salary
from employees_names 
inner join roles on employees_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where salary.monthly_salary in('1100','1500','2000')
order by salary.monthly_salary asc;