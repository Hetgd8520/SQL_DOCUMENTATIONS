-- EMPLOYEE TABLE
CREATE TABLE emp(
eid INT PRIMARY KEY,
fname VARCHAR(20),
lname VARCHAR(20),
department_id INT,
FOREIGN KEY(department_id) REFERENCES dept(did)
);
INSERT INTO emp(eid,fname,lname,department_id) VALUES(1,"JOHN","DOE",10),(2,"JANE","SMITH",20),(3,"ALICE","JOHNSON",10),
(4,"BOB","BROWN",NULL),(5,"EMILY","DAVIS",30);
SELECT * FROM emp;
DROP TABLE emp;

-- DEPARTMENT TABLE
CREATE TABLE dept(
did INT PRIMARY KEY,
dname VARCHAR(20)
); 
INSERT INTO dept(did,dname) VALUES(10,"SALES"),(20,"MARKETING"),(30,"IT"),(40,"HR");
SELECT * FROM dept;
DROP TABLE dept;

-- PROJECT TABLE
CREATE TABLE project(
pid INT PRIMARY KEY,
pname VARCHAR(20),
department_id INT,
FOREIGN KEY(department_id) REFERENCES dept(did)
);
INSERT INTO project(pid,pname,department_id) VALUES(101,"PROJECT A",10),(102,"PROJECT B",20),(103,"PROJECT C",30),(104,"PROJECT D",40);
SELECT * FROM project;
DROP TABLE project;

CREATE TABLE salaries (
    employee_id INT,
    salary INT,
    FOREIGN KEY(employee_id) REFERENCES emp(eid)
);
INSERT INTO salaries(employee_id, salary) VALUES(1, 50000),(2, 60000),(3, 55000),(4, 65000),(5, 85000);
select * from salaries;
DROP TABLE salaries;

-- Retrieve the names of employees and their corresponding department names.
select e.eid,e.fname,d.dname FROM emp e JOIN dept d ON e.department_id = d.did;

-- Retrieve all employees and their department names. Include employees who do not have a department assigned.
SELECT e.eid,e.fname,d.dname FROM emp e LEFT JOIN dept d ON e.department_id = d.did;

-- Retrieve all departments and the names of employees in those departments. Include departments that have no employees.
SELECT e.fname, e.lname, d.dname
FROM emp e
RIGHT JOIN dept d ON e.department_id = d.did;

-- Retrieve all possible combinations of employees and projects.
SELECT e.fname,p.pname FROM emp e CROSS JOIN project p;

-- show which employee doing which project
SELECT e.eid,e.fname,d.did,p.pname FROM emp e JOIN dept d ON e.department_id=d.did JOIN project p ON p.department_id = d.did;

--  Find pairs of employees who are in the same department.
SELECT e.fname , e1.fname , d.dname FROM emp e JOIN emp e1 ON e.department_id = e1.department_id AND e1.eid>e.eid JOIN dept d 
ON d.did = e1.department_id; 

-- Retrieve the names of employees who are in the Sales department.
SELECT e.fname , d.dname FROM emp e JOIN dept d WHERE e.department_id=d.did AND d.dname = "SALES";

-- Retrieve the names of employees who are in departments with more than one employee.
SELECT e.fname , d.dname FROM emp e JOIN (SELECT department_id FROM emp GROUP BY department_id HAVING COUNT(eid)>1) AS subquery 
ON e.department_id=subquery.department_id JOIN dept d ON d.did = e.department_id;

-- Retrieve all employees and all departments, including those without matches. 
SELECT e.fname,d.dname FROM emp e LEFT JOIN dept d ON e.department_id=d.did 
UNION
SELECT e.fname,d.dname FROM emp e RIGHT JOIN dept d ON e.department_id=d.did;

-- Retrieve the names of employees, their departments, and the projects they are working on.
SELECT e.eid,e.fname,d.dname,p.pname FROM emp e JOIN dept d ON e.department_id=d.did JOIN project p ON p.department_id=d.did;


-- Retrieve the average salary for each department.
SELECT d.dname , AVG(s.salary) FROM emp e JOIN dept d ON e.department_id = d.did JOIN salaries s 
ON s.employee_id = e.eid GROUP BY d.dname;

-- retrive how many persons are there in perticular department
SELECT d.dname , COUNT(e.fname) FROM emp e JOIN dept d ON e.department_id=d.did group by d.dname;

-- Retrieve the names of employees who are in departments that have at least one project.
SELECT e.fname , d.dname ,p.pname FROM emp e JOIN dept d ON e.department_id=d.did JOIN project p ON 
p.department_id=d.did;

-- Retrieve the names of employees who are in departments that have NOT any project.
SELECT * FROM emp WHERE eid NOT IN(SELECT DISTINCT e.eid FROM emp e JOIN dept d ON e.department_id=d.did);

-- retrive the project on nobody working
SELECT e.fname,d.dname,p.pname FROM emp e JOIN dept d ON e.department_id=d.did RIGHT JOIN
project p ON p.department_id=d.did WHERE d.dname IS NULL AND e.fname IS NULL;

-- Retrive the department which have no employee
SELECT * FROM dept WHERE did NOT IN 
(SELECT distinct department_id FROM emp WHERE department_id IS NOT NULL);

-- Retrieve the names of employees who are in departments that have both projects and employees
select d.dname,p.pname from dept d join project p on d.did=p.department_id;
select d.dname,e.fname from emp e join dept d on e.department_id=d.did;
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM  project;

-- Retrieve the names of employees who are in departments that have projects but no employees.

-- NORMALIZATION FORMS
-- 1NF
-- convert the below table in 1NF
-- Student ID	Name	Courses
--    1	       Alice	Math, Physics
--    2	       Bob	    Chemistry
--    3	     Charlie	Biology, Math
-- in this table in course column ther is two values so the table need to be convert in 1nf normalization
-- split that column in multiple rows to convert table in 1NF
CREATE TABLE Students (
    StudentID INT,
    Name VARCHAR(50),
    Courses VARCHAR(255)
);
INSERT INTO Students (StudentID, Name, Courses)
VALUES
(1, 'Alice', 'Math, Physics'),
(2, 'Bob', 'Chemistry'),
(3, 'Charlie', 'Biology, Math');

CREATE TABLE Students_1NF (
    StudentID INT,
    Name VARCHAR(50),
    Course VARCHAR(50)
);
INSERT INTO Students_1NF (StudentID, Name, Course)
SELECT StudentID, Name, TRIM(value) AS Course
FROM Students
CROSS APPLY STRING_SPLIT(Courses, ',');