-- TWO TABLE QUERY
CREATE TABLE emp(
eid INT PRIMARY KEY,
fname VARCHAR(20) NOT NULL,
lname VARCHAR(20) NOT NULL,
department_id INT,
FOREIGN KEY(department_id) REFERENCES dept(did)
);
INSERT INTO emp(eid,fname,lname,department_id) VALUES(1,"JOHN","DOE",10),(2,"DANE","SMITH",20),(3,"ALICE","JONSON",10),(4,"BOB","BROWN",NULL),(5,"EMILY","DAVIS",30);
SELECT * FROM emp;
DROP TABLE emp;
UPDATE emp SET department_id=NULL WHERE eid = 5;

CREATE TABLE dept(
did INT PRIMARY KEY,
dname VARCHAR(20)
);
INSERT INTO dept(did,dname) VALUES(10,"sales"),(20,"marketing"),(30,"it");
SELECT * FROM dept;

-- START QUERY FROM HERE
-- Write a query to get the names of employees and their corresponding department names.
SELECT e.eid,e.fname,e.lname,d.dname from emp e JOIN dept d WHERE e.department_id=d.did;

-- Write a query to get all employees and their department names. Include employees who do not have a department assigned.
SELECT e.eid,e.fname,e.lname,d.dname FROM emp e LEFT JOIN dept d ON e.department_id = d.did;

-- Write a query to get all departments and the names of employees in those departments. Include departments that have no employees.
SELECT d.did,d.dname,e.fname,e.lname FROM dept d LEFT JOIN emp e ON d.did = e.department_id;

-- Write a query to get all employees and all departments, including those without matches.
SELECT e.eid,e.fname,e.lname,e.department_id,d.dname FROM emp e LEFT JOIN dept d ON e.department_id=d.did 
UNION 
SELECT e.eid,e.fname,e.lname,e.department_id,d.dname FROM emp e RIGHT JOIN dept d ON e.department_id=d.did;

-- Write a query to find pairs of employees who are in the same department
SELECT e1.eid,e1.fname,e2.eid,e2.fname FROM emp e1 JOIN emp e2 ON e1.department_id = e2.department_id AND e1.eid<e2.eid;

-- Write a query to get the names of employees who are in the Sales department.
SELECT e.eid,e.fname,e.lname,d.dname FROM emp e JOIN dept d ON e.department_id=d.did WHERE d.dname = "sales";

-- Write a query to get the names of employees who are in departments with more than one employee.
SELECT department_id , COUNT(department_id) FROM emp GROUP BY department_id;
SELECT e.fname FROM emp e JOIN 
(SELECT department_id FROM emp GROUP BY department_id HAVING COUNT(department_id)>1)
AS subquery ON e.department_id = subquery.department_id;

-- show the department name and total of how many employ are there in their department
SELECT d.dname,COUNT(e.eid) FROM emp e JOIN dept d ON e.department_id = d.did GROUP BY d.dname;

-- from here work on three tables
CREATE TABLE salary(
employee_id INT,
salary INT,
FOREIGN KEY(employee_id) REFERENCES emp(eid)
);
INSERT INTO salary (employee_id, salary) VALUES(1, 50000),(2, 60000),(3, 55000),(4, NULL);

-- Write a query to get the names of employees, their departments, and their salaries.
SELECT e.fname,d.dname,s.salary FROM emp e JOIN dept d ON e.department_id=d.did JOIN salary s 
ON s.employee_id=e.eid;

-- Write a query to get the average salary for each department.
SELECT d.dname,AVG(s.salary) FROM dept d JOIN emp e ON d.did=e.department_id JOIN salary s 
ON s.employee_id=e.eid GROUP BY d.dname;

-- Write a query to get a list of all employees and departments, with a column indicating 
			-- whether the row is an employee or a department   .
