-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(255)NOT   NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR(255)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(255)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Code to display employee number, first and last name, sex and salary.
SELECT emp.emp_no,emp.last_name,emp.first_name,emp.sex,sal.salary
FROM employees as emp
inner join salaries as sal on emp.emp_no=sal.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986
select first_name,last_name,hire_date 
from employees 
where extract(year from hire_date)=1986

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
select dm.dept_no,dep.dept_name,emp.emp_no,emp.last_name,emp.first_name
from departments as dep
inner join dept_manager as dm on dep.dept_no=dm.dept_no
inner join employees as emp on emp.emp_no=dm.emp_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select emp.emp_no,dep.dept_no,emp.last_name,emp.first_name,dep.dept_name
from departments as dep
inner join dept_emp as de on dep.dept_no=de.dept_no
inner join employees as emp on de.emp_no=emp.emp_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name,last_name, sex from employees 
where first_name='Hercules' and last_name LIKE'B%'

--List each employee in the Sales department, including their employee number, last name, and first name.
select dep.dept_name,emp.emp_no,emp.last_name,emp.first_name
from departments as dep
inner join dept_emp as de on de.dept_no=dep.dept_no
inner join employees as emp on emp.emp_no=de.emp_no
where dep.dept_name ='Sales'

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select dep.dept_name,emp.emp_no,emp.last_name,emp.first_name
from departments as dep
inner join dept_emp as de on de.dept_no=dep.dept_no
inner join employees as emp on emp.emp_no=de.emp_no
where dep.dept_name ='Sales' or dep.dept_name='Development'

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name, count(last_name) as "Last_Name_Count"
from employees
group by last_name
order by "Last_Name_Count" DESC;