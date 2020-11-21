DROP TABLE salaries
select * from salaries

create table salaries (
emp_no int primary key,
salary int 
);

drop table titles 
select * from titles

create table titles(
title_id varchar(30) primary key,
title varchar(30)
);

drop table dept_manager
select * from dept_manager

create table dept_manager(
dept_no varchar(30),
emp_no int,
primary key (dept_no,emp_no)
);


drop table departments
select * from departments 

create table departments (
dept_no varchar(30) primary key, 
dept_name varchar(30)
--FOREIGN KEY (dept_no) REFERENCES dept_manager(dept_no)
);


drop table employees

create table employees (
emp_no int primary key,
emp_title_id varchar(64),
birth_date date,
first_name varchar(30),
last_name varchar(30),
sex varchar(30),
hire_date date,
FOREIGN KEY (emp_no) REFERENCES salaries(emp_no),
FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);


drop table dept_emp
select * from dept_emp 

create table dept_emp (
emp_no int,
dept_no varchar(30),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
PRIMARY KEY (emp_no, dept_no)
);


-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e 
inner join salaries as s on
e.emp_no=s.emp_no

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
select e.first_name, e.last_name, e.hire_date
from employees as e 
where extract (year from e.hire_date) =1986

select extract (year from hire_date) from
employees limit 10

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.


select d.dept_no, d.dept_name, dm.emp_no as "manager", e.last_name, e.first_name 
from employees as e 
inner join dept_emp as de 
on e.emp_no=de.emp_no
  inner join departments as d
  on de.dept_no = d.dept_no
    inner join dept_manager as dm
	on d.dept_no=dm.dept_no

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.


SELECT e.emp_no, e.last_name, e.first_name, d.dept_name 
FROM employees as e 
inner join dept_emp as de 
on e.emp_no=de.emp_no
  inner join departments as d
  on de.dept_no = d.dept_no

	
-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT e.first_name, e.last_name, e.sex
from employees as e
where e.first_name= 'Hercules'
	and substr(e.last_name,1,1)='B'


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e 
inner join dept_emp as de 
on e.emp_no=de.emp_no
  inner join departments as d
  on de.dept_no=d.dept_no
  where de.dept_no='d007'

select * from  departments

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e 
inner join dept_emp as de 
on e.emp_no=de.emp_no
  inner join departments as d
  on de.dept_no=d.dept_no
  where de.dept_no='d007'
  	or de.dept_no='d005'

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select employees.last_name, count(*) as "Employees" from 
employees 
group by employees.last_name 
order by "Employees" DESC

