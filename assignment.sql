use hr;
#1
--  Display all information in the tables EMP and DEPT. 
select * from employees;
select * from departments;

#2
--  Display only the hire date and employee name for each employee. 
select  first_name, hire_date from employees;

#3
-- Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title.. 
select CONCAT(first_name,',',job_id) as 'Employee and Title' from employees;

#4
--  Display the hire date, name and department number for all clerks. 
select hire_date,first_name,department_id,job_id from employees where job_id like "%clerk%" ;

#5 
-- Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT..
select concat(employee_id," , ",first_name,"  ",last_name,",",email,",",phone_number,",",hire_date,",",job_id,",",salary,",",commission_pct,",",manager_id,",",department_id) as OUTPUT
from employees;

#6
-- Display the names and salaries of all employees with a salary greater than 2000. 
select concat(first_name," ",last_name) as EMP,salary
from employees
where salary > 2000;

#7
-- Display the names and dates of employees with the column headers "Name" and "Start Date".. 
select concat(first_name," ",last_name) as  Name , hire_date as "start_date"
from employees;

#8
-- . Display the names and hire dates of all employees in the order they were hired. 
select concat(first_name," ",last_name) as  Name , hire_date as "start_date"
from employees
order by hire_date;

#9
-- . Display the names and salaries of all employees in reverse salary order. 
select concat(first_name," ",last_name) as EMP,salary
from employees
order by salary desc;

#10
-- Display 'ename" and "deptno" who are all earned commission and display salary in reverse order. 
select concat(first_name,'',last_name) as EMP,salary,department_id,commission_pct 
from employees
where commission_pct > 0
order by salary desc;

#11
-- Display the last name and job title of all employees who do not have a manager ..
select employees.last_name,jobs.job_title,employees.manager_id
from employees join jobs on employees.job_id=jobs.job_id
where employees.manager_id is null;

#12
-- Display the last name, job, and salary for all employees whose job is sales representative
-- or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name,salary,job_id
from hr.employees
where job_id in("SA_REP","ST_CLERK")
and salary not in(2500,3500,5000);



#page 2

#1
-- Display the maximum, minimum and average salary and commission earned. 

select commission_pct, max(salary),min(salary),avg(salary)
from employees
where commission_pct > 0
group by commission_pct
order by commission_pct;

#2
#Display the department number, total salary payout and total commission payout for each department. 

select department_id,sum(salary),sum(commission_pct)
from employees
group by department_id;

#3
# Display the department number and number of employees in each department. 
select department_id,count(employee_id)
from employees
group by department_id;

#4
#) Display the department number and total salary of employees in each department
select department_id,sum(salary)
from employees
group by department_id;

#5
#Display the employee's name who doesn't earn a commission. Order the result set without using the column name 
select concat(first_name,'',last_name) as EMPName,commission_pct
from employees
where commission_pct  is null
order by EMPName;

#6
#Display the employees name, department id and commission. If an Employee doesn't earn the commission, 
#then display as 'No commission'. Name the columns appropriately...
select concat(first_name,'',last_name) as EMPName,department_id,commission_pct,
case
when commission_pct is null then " No Commission" 
end as appropriately
from employees;

#7
#Display the employee's name, salary and commission multiplied by 2. If an Employee
#doesn't earn the commission, then display as 'No commission. Name the columnsappropriately
select concat(first_name,'',last_name) as EMPName,department_id,commission_pct,
case
when commission_pct > 0 then commission_pct*2
when commission_pct is null then " No Commission" 
end as appropriately
from employees;

#8
# Display the employee's name, department id who have the first name same as another employee in the same department.
select first_name,department_id
from employees
group by department_id,first_name
having count(first_name) > 1;

#9
#Display the sum of salaries of the employees working under each Manager. 
select sum(salary),manager_id
from employees
group by manager_id;

select sum(e.salary),m.first_name as manger_name
from employees as e join employees as m 
on e.manager_id = m.employee_id
group by m.first_name;

select m.employee_id,m.first_name
from employees as e join employees as m 
on e.manager_id = m.employee_id
group by m.employee_id;


#10
#Select the Managers name, the count of employees working under and the department ID of the manager. 
select m.first_name as manger_name,m.department_id,count(e.first_name) as emp_count
from employees as e join employees as m 
on e.manager_id = m.employee_id
group by m.first_name,m.department_id ;

#11
#) Select the employee name, department id, and the salary. Group the result with the
#manager name and the employee last name should have second letter 'a! .
select concat(first_name,'',last_name) as EMPName,department_id,salary
from employees
where last_name like"_a%" ;

select e.last_name as emp,m.last_name as m_name,e.salary,e.department_id
from employees as e join employees as m
on e.manager_id=m.manager_id
where e.last_name like "_a%"and m.last_name like "_a%";


#12
#Display the average of sum of the salaries and group the result with the department id.
# Order the result with the department id.
select  sum(salary),department_id 
from employees
group  by department_id;


#13
#Select the maximum salary of each department along with the department id 
select max(salary),department_id 
from employees
group by department_id;

select max(employees.salary),departments.department_name,departments.department_id
from employees join departments on employees.department_id=departments.department_id
group by departments.department_id
order by departments.department_id;

#14
# Display the commission, if not null display 10% of salary, if null display a default value 1
select salary,commission_pct,
case
when commission_pct >0 then salary*0.10
when commission_pct is null then "1"
end  as salary
from employees;

#page 3

#1
#. Write a query that displays the employee's last names only from the string's 2-5th
-- position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label. 
select last_name,concat(upper(substring(last_name,2,1)),(substring(last_name,3,3))) as 2_to_5
from employees;

#2
--  Write a query that displays the employee's first name and last name along with a " in
 -- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the
 -- month on which the employee has joined.
 select concat(first_name,'-',last_name),month(hire_date)
 from employees;
 
 #3
--  Write a query to display the employee's last name and if half of the salary is greater than
 -- ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of
 -- 1500 each. Provide each column an appropriate label.
 select last_name,salary,
 case
 when salary/2 > 10000 then round(salary + salary*0.1 + 1500 , 2)
 when salary/2 < 10000 then round( salary + salary* 0.115 + 1500 , 2 )
end as  bonus_for_EMP
from employees;

#4
-- Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end,
 -- department id, salary and the manager name all in Upper case, if the Manager name
-- consists of 'z' replace it with '$! 

select  concat( substring(e.employee_id,1,2) , "00" , substring(e.employee_id,3), "E ") as new_emp_id,e.department_id,e.salary,
replace(m.last_name,"Z" ,'$') as Mname
from employees as e join employees as m on e.manager_id=m.employee_id;

#5
-- Write a query that displays the employee's last names with the first letter capitalized and
-- all other letters lowercase, and the length of the names, for all employees whose name
-- starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names..
select concat(upper(substring(last_name,1,1)),lower(substring(last_name,2))) as E_name , length(last_name) as "length"
from employees
where (last_name like "J%") or (last_name like "A%") or (last_name like "M%")
order by last_name;

#6
--- Create a query to display the last name and salary for all employees. Format the salary to
-- be 15 characters long, left-padded with $. Label the column SALARY 

select last_name , lpad((rpad(salary,16,"0")),17,"$")  as SALARY
from employees;

#7
-- Display the employee's name if it is a palindrome
select  first_name,
case
when first_name =reverse(first_name) then 'palindrom'
end palindrom
from employees;

#8 Display First names of all employees with initcaps. 
select upper(first_name) from employees;
select concat(upper(substring(first_name,1,1)),lower(substring(first_name,2))," ",upper(substring(last_name,1,1)),lower(substring(last_name,2))) as emp_name
 from employees;
 
#9
-- From LOCATIONS table, extract the word between first and second space from the
-- STREET ADDRESS column. 
select  street_address,substring_index(substring_index(street_address,' ',2),' ',-1)
 from locations;

#10
-- . Extract first letter from First Name column and append it with the Last Name. Also add
-- "@systechusa.com" at the end. Name the column as e-mail address. All characters should
-- be in lower case. Display this along with their First Name. 
select lower(concat(last_name,substring(first_name,1,1),"@systechusa.com"))as email_address,first_name
 from employees;
 
 #11
 -- Display the names and job titles of all employees with the same job as Trenna. 
 select employees.first_name,jobs.job_title
from employees join jobs on employees.job_id=jobs.job_id
where (select first_name like "%trenna%");

#12
-- Display the names and department name of all employees working in the same city as Trenna.
 select employees.first_name,departments.department_name,locations.city
from employees join departments on employees.department_id=departments.department_id join locations on locations.location_id=departments.location_id
where city like "South San Francisco";

#13
-- Display the name of the employee whose salary is the lowest.
 select first_name,salary
 from employees
 where salary=(select min(salary) from employees);
 
 #14
 -- Display the names of all employees except the lowest paid.
 select first_name,salary
 from employees
 where salary<>(select min(salary) from employees)
 order by salary asc;
 
 #page 4
 #1
 -- . Write a query to display the last name, department number, department name for all employees.
 select e.last_name,e.department_id,d.department_name
 from employees e join departments d on e.department_id= d.department_id;
 
 #2
 -- . Create a unique list of all jobs that are in department 4. Include the location of the department in the output.
select employees.job_id,departments.department_id,locations.city
from employees join departments on employees.department_id=departments.department_id join locations on locations.location_id=departments.location_id
where departments.department_id = 40;

#3
-- . Write a query to display the employee last name,department name,location id and city of
-- all employees who earn commission.
 select employees.last_name,departments.department_name,locations.location_id,locations.city,employees.commission_pct
 from employees join departments on employees.department_id = departments.department_id join locations on locations.location_id = departments.location_id
 where commission_pct is not null;
 
 #4
 -- Display the employee last name and department name of all employees who have an 'a' in their last name 
 select employees.last_name,departments.department_name
 from employees join departments on employees.department_id = departments.department_id
 where employees.last_name like "%a%";
 
 #5
 -- . Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA. 
select employees.last_name,employees.job_id,departments.department_id,departments.department_name,countries.country_name
from employees join departments on employees.employee_id = departments.department_id join locations on locations.location_id = departments.location_id 
join  countries on countries.country_id=locations.country_id
where countries.country_name like "United States of America";

#6
-- Display the employee last name and employee number along with their manager's last
-- name and manager number.
select e.last_name as EMP_name,e.employee_id as EMP_ID,m.last_name as manager_name ,m.employee_id as manager_id
from employees as e join employees as m on e.manager_id=m.employee_id;

#7
-- Display the employee last name and employee number along with their manager's last
-- name and manager number (including the employees who have no manager). 
select e.last_name as EMP_name,e.employee_id as EMP_ID,m.last_name as manager_name ,m.employee_id as manager_id
from employees as e left join employees as m on e.manager_id=m.employee_id;

#8
-- Create a query that displays employees last name,department number,and all the
-- employees who work in the same department as a given employee
select last_name,department_id
from employees
group by last_name,department_id
having count(last_name) > 1;

#9
-- Create a query that displays the name,job,department name,salary,grade for all
-- employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) 
select employees.first_name,employees.job_id,departments.department_name,employees.salary,
case
when  employees.salary>=20000 then "A"
when employees.salary>=10000 then "B"
when employees.salary <10000 then "C"
end as "grade"
from employees join departments on employees.employee_id=departments.department_id
order by grade;

#10
-- Display the names and hire date for all employees who were hired before their
-- managers along withe their manager names and hire date. Label the columns as Employee
-- name, emp_hire_date,manager name,man_hire_date
select e.first_name as emp_name,e.hire_date as emp_hire_date,m.first_name as manager_name,m.hire_date as man_hire_date
from employees as e join employees as m on e.manager_id=m.employee_id;

#page 5
#1
-- Write a query to display the last name and hire date of any employee in the same
-- department as SALES.
select last_name,hire_date,department_id,job_id
from employees
where job_id = "SA_REP";

#2
-- . Create a query to display the employee numbers and last names of all employees who
-- earn more than the average salary. Sort the results in ascending order of salary. 
select employee_id,last_name,salary
from employees
where salary > (select avg(salary) from employees)
order by salary asc;

#3
--  Write a query that displays the employee numbers and last names of all employees who
-- work in a department with any employee whose last name contains a' u 
select employee_id,last_name,department_id
from employees
where last_name like "%u%";

#4
-- . Display the last name, department number, and job ID of all employees whose department location is ATLANTA. 
 select employees.last_name,departments.department_id,employees.job_id,locations.city
from employees join departments on employees.department_id=departments.department_id join locations on locations.location_id=departments.location_id
where locations.city = "Toronto";

#5
--  Display the last name and salary of every employee who reports to FILLMORE. 
select last_name,salary
from employees
order by salary asc;

#6
--  Display the department number, last name, and job ID for every employee in the OPERATIONS department. 
select employees.department_id,employees.last_name,employees.job_id,departments.department_name
from employees join departments on employees.employee_id=departments.department_id
where departments.department_name="operations";

#7
-- Modify the above query to display the employee numbers, last names, and salaries of all
-- employees who earn more than the average salary and who work in a department with any
-- employee with a 'u'in their name. 
select employee_id,last_name,salary,department_id
from employees
where salary > (select avg(salary) from employees) and last_name like "%u%" 
order by salary ;

#8
-- Display the names of all employees whose job title is the same as anyone in the sales dept. 
select employees.first_name,jobs.job_title
from employees join jobs on employees.job_id = jobs.job_id
where jobs.job_title like "%Sales%";
 
 #9
-- Write a compound query to produce a list of employees showing raise percentages,
-- employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise,
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are
-- given a 15% raise, and employees in department 6 are not given a raise. 
 select employee_id,salary,department_id,
case 
when department_id = 10  then "5% Raise"
when department_id = 30  then "5% Raise"
when department_id = 20  then "10% Raise"
when department_id = 40  then "15% Raise"
when department_id = 50 then "15% Raise"
when department_id = 60 then "No Raise"
end as RAIS
from employees
order by department_id;

#10
-- Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.
 select last_name,salary
 from employees
 limit 3;

#11
-- Display the names of all employees with their salary and commission earned. Employees
-- with a null commission should have O in the commission column 
select first_name,salary,commission_pct
from employees
where commission_pct=(select replace(commission_pct,null,0) from employees);

select first_name,salary,commission_pct,
case
when commission_pct is null then "0"
when commission_pct is not null then commission_pct
end as colum
from employees;

#12
--  Display the Managers (name) with top three salaries along with their salaries and department information.
select distinct( m.first_name),m.salary,m.department_id
from employees as e join employees as m on e.manager_id=m.employee_id
limit 3;

#page 6
create table empdate
(
emp_id int,
hire_date date,
resignation_date date
);



insert into empdate values(1,'2000-01-01','2013-10-07');
insert into empdate values(2,'2003-12-04','2017-08-03');
insert into empdate values(3,'2012-09-22','2015-06-21');
insert into empdate values(4,'2015-04-13',null);
insert into empdate values(5,'2016-06-03',null);
insert into empdate values(6,'2017-08-08',null);
insert into empdate values(7,'2016-11-13',null);

select * from empdate;


#1
select datediff(hire_date,resignation_date) from empdate;

select emp_id,
case
when resignation_date is not null then concat(floor( datediff(resignation_date,hire_date)/365) ,"year ",floor(datediff(resignation_date,hire_date)%365/30) , "month ",datediff(resignation_date,hire_date)%365%30,"day")
when resignation_date is null then concat(floor(datediff(NOW(),hire_date)/365),"year ",floor(datediff(NOW(),hire_date)%365/30)," month ",datediff(now(),hire_date)%365%30,"day ")
end as date
from empdate;

#2
select date_format(hire_date,'%m,%d,%Y') as date_1,resignation_date,
case
 when resignation_date is null then  "dec,01th,1900"
 when resignation_date is not null then  date_format(resignation_date,'%M,%d,%Y')
end as date
from empdate;

#3
select emp_id,
case
when resignation_date is not null then concat(floor( datediff(resignation_date,hire_date)/365) ,"year ",floor(datediff(resignation_date,hire_date)%365/30) , "month ")
when resignation_date is null then concat(floor(datediff(NOW(),hire_date)/365),"year ",floor(datediff(NOW(),hire_date)%365/30)," month ")
end as EMP_EXP
from empdate;




