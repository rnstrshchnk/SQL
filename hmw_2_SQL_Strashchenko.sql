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
alter table employee_names 
rename column employee_name to name;

--������� ������� taxi
alter table roles 
drop column taxi;

--�������� �������� � �������������� id_salary
insert into roles_salary(id_role, id_salary)
values (1,15);

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

-- 7. ������� ����� � ��������� ������ Java �������������.
select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id 
where roles.role_title like '%Java%';

-- 8. ������� ����� � ��������� ������ Python �������������.
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

-- 9. ������� ����� � ��������� ���� QA ���������.
select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id 
where roles.role_title like '%QA%';

-- 10. ������� ����� � ��������� ������ QA ���������.
select employee_names.name, roles.role_title, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join 
where roles.role_title like '%manual%';

-- 11. ������� ����� � ��������� ��������������� QA
select employee_names.name, roles.role_title 
from employee_names inner join roles on employee_names.id_role = roles.id 
where roles.role_title like '%automation%';

-- 12. ������� ����� � �������� Junior ������������
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%junior%';

-- 13. ������� ����� � �������� Middle ������������
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%middle%';

-- 14. ������� ����� � �������� Senior ������������
select employee_names.name, salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%senior%';

-- 15. ������� �������� Java �������������
select salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Java%';

-- 16. ������� �������� Python �������������
select salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Python%';

-- 17. ������� ����� � �������� Junior Python �������������
insert into roles_salary(id_role, id_salary)
values (10,11),
	   (11,12),
	   (12,9);
	  
select salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%Python%' and roles.role_title like '%junior%';

-- 18. ������� ����� � �������� Middle JS �������������
insert into roles (role_title)
values ('JS_developer_junior'),
	  ('JS_developer_middle'),
	  ('JS_developer_senior');

select * from roles;	

insert into employee_names(id_role, name)
values (10,'Aleksandr'),
	   (11,'Inna'),
	   (12,'Vladimir'),
	   (12,'Pavel');
	  
insert into roles_salary(id_role, id_salary)
values (10,11),
	   (11,12),
	   (12,9);
	  
select * from employee_names;

select salary.monthly_salary  
from employee_names 
inner join roles on employee_names.id_role = roles.id 
inner join roles_salary on roles.id = roles_salary.id_role 
inner join salary on roles_salary.id_salary = salary.id 
where roles.role_title like '%JS%' and roles.role_title like '%middle%';

-- 19. ������� ����� � �������� Senior Java �������������
-- 20. ������� �������� Junior QA ���������
-- 21. ������� ������� �������� ���� Junior ������������
-- 22. ������� ����� ������� JS �������������
-- 23. ������� ����������� �� QA ���������
-- 24. ������� ������������ �� QA ���������
-- 25. ������� ���������� QA ���������
-- 26. ������� ���������� Middle ������������.
-- 27. ������� ���������� �������������
-- 28. ������� ���� (�����) �������� �������������.
-- 29. ������� �����, ��������� � �� ���� ������������ �� �����������
-- 30. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� �� 1700 �� 2300
-- 31. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ������ 2300
-- 32. ������� �����, ��������� � �� ���� ������������ �� ����������� � ������������ � ������� �� ����� 1100, 1500, 2000