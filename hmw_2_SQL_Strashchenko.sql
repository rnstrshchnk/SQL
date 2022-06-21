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
	 
select * from salary;

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
alter table roles 
rename column parking to taxi;

--������� ������� taxi
alter table roles 
drop column taxi;

--�������� �������� � �������������� id_salary
insert into roles_salary(id_role, id_salary)
values (1,15);
