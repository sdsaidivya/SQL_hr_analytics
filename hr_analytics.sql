-- Created a database and imported teh particular file into it

-- Creating a database named education 
create database hr;

-- Using the database
use hr;

-- show tables -- to see the tables 
show tables;

-- to see the structure of the table 
describe table hr_analytics;

-- to get the row count
Select count(*) as no_rows from hr_analytics;

-- to get the coulmn count
SELECT COUNT(*) as no_col
FROM information_schema.columns
WHERE table_schema = 'hr'
AND table_name = 'hr_analytics';

-- to get the first 10 rows of the table 
select * from hr_analytics limit 10;

-- to change the column name
alter table hr_analytics rename column ï»¿EmpID to emp_id;

-- to get the last 10 rows of the table 
select * from hr_analytics order by emp_id desc limit 10;

-- to check the duplicate rows:
select count(distinct(emp_id)) from hr_analytics;

-- to identify the duplicate rows

select emp_id,sum(employeecount) emp_count from hr_analytics group by 1 having emp_count >1;

-- to get the total count of employees
select count(emp_id) as empolyee_count from hr_analytics;

-- to get the attrition count of employees
select count(attrition) as attrition_count from hr_analytics where attrition = "YES";

-- to get the attrition_rate 
select round((select count(attrition) from hr_analytics where attrition = "YES")/
(select  count(emp_id) as empolyee_count from hr_analytics),2)*100 as attrition_rate ;

-- to get the average age of the empolyees 
select round(avg(age),2) as avg_age from hr_analytics;

-- to get the average monthly salary of the empolyee
select round(avg(monthlyincome),2) as avg_age from hr_analytics;

-- to get the average working years of the empolyee
select round(avg(yearsatcompany),2) as avg_age from hr_analytics;

-- to get the count of empolyees based on gender 
select gender,count(emp_id) as emp_count from hr_analytics group by 1;

-- to create a temproary table whose attrition status is Yes
create temporary table attrition_emp_id(
select * from hr_analytics where Attrition = "yes");

--  the get attriration count based on gender 
select a.gender,count(b.emp_id) as attrition_emp_count from hr_analytics a 
join attrition_emp_id b using (emp_id)
group by 1;

-- to get the attrition rate based on gender
with cte_gender_att_count as (select a.gender,count(b.emp_id) as attrition_emp_count from hr_analytics a 
join attrition_emp_id b using (emp_id)
group by 1)
select gender,attrition_emp_count,round(attrition_emp_count/count(emp_id),2) as 
attr_rate from hr_analytics a join cte_gender_att_count b using 


-- to get the attriration count based on educatiom field;
select a.EducationField,count(b.emp_id) as attrition_emp_count from hr_analytics a 
join attrition_emp_id b using (emp_id)
group by 1 order by 2 desc;

-- to get the attriration count based on department;
select a.Department,count(b.emp_id) as attrition_emp_count from hr_analytics a 
join attrition_emp_id b using (emp_id)
group by 1 order by 2 desc;

-- to get the max salary based on department 
select department,max(monthlyincome) as Max_monthly_income,
min(monthlyincome) as min_monthly_income
 from hr_analytics group by 1;
 
 
 -- to get the job roles
 select jobrole,max(monthlyincome) as Max_monthly_income,
min(monthlyincome) as min_monthly_income from hr_analytics group by 1;


 -- to get the attriration count based on jobrole;
select a.JobRole,count(b.emp_id) as attrition_emp_count from hr_analytics a 
join attrition_emp_id b using (emp_id)
group by 1 order by 2 desc;

