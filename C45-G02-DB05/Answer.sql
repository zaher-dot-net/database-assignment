-- C45-G02-DB05                                                                                      
----------------------------------------------- Part 01 -----------------------------------------------
--- Use ITI DB

use ITI;

-- 1. Retrieve a number of students who have a value in their age. 

select count(St_Age)[number of students who have a value in their age]
from Student where St_Age is not null

-- 2. Display number of courses for each topic name 


select distinct Topic.Top_Id, Top_Name , count(Course.Crs_Id) over (Partition by Topic.Top_Id)
from Topic left join Course
on Course.Top_Id = Topic.Top_Id;

select Topic.Top_Id, Topic.Top_Name , count(Course.Crs_Id)
from Topic left join Course
on Course.Top_Id = Topic.Top_Id
group by Topic.Top_Id, Topic.Top_Name;


-- 3. Display student with the following Format (use isNull function)
				--	Student ID
				-- 		Student Full Name
				--		Department name

select Student.St_Id , isNull(Student.St_Fname,'') + ' ' + isNull(Student.St_Lname,'') , Department.Dept_Name
from Student 
left join Department on Student.Dept_Id = Department.Dept_Id;

-- 4. Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function” 

select Ins_Name , coalesce(Salary,0000)
from Instructor;

-- 5. Select Supervisor first name and the count of students who supervises on them

select 
    Sup.St_Fname AS SupervisorName,
    count(Stu.St_Id) AS StudentsCount
from Student Stu
JOIN Student Sup
    ON Stu.St_super = Sup.St_Id
group by Sup.St_Fname;

-- 6. Display max and min salary for instructors

SELECT 
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary
FROM Instructor;

-- 7. Select Average Salary for instructors 

SELECT 
    AVG(Salary) AS AvgSalary
FROM Instructor;


----------------------------------------------- Part 02 -----------------------------------------------
-- Use MyCompany DB

Use MyCompany;

-- 1. For each project, list the project name and the total hours per week (for all employees) spent on that project.
SELECT 
    P.Pname AS ProjectName,
    SUM(W.Hours) AS TotalHoursPerWeek
FROM Project P
JOIN works_for W
    ON P.Pnumber = W.Pno
GROUP BY P.Pname;



-- 2. For each department, retrieve the department name and the maximum, minimum and average salary of its employees.

SELECT 
    D.Dname AS DepartmentName,
    MAX(E.Salary) AS MaxSalary,
    MIN(E.Salary) AS MinSalary,
    AVG(E.Salary) AS AvgSalary
FROM Departments D
JOIN Employee E
    ON D.Dnum = E.Dno
GROUP BY D.Dname;
