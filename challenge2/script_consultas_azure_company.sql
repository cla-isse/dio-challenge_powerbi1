use azure_company

-- 1. Consultas

select * from employee;
select * from dependent;

-- Quantos dependentes cada SSN possui?
select Ssn, count(Essn) as dependents from employee e, dependent d where (e.Ssn = d.Essn) group by 1;

-- Quais os dados do funcionário com as características (Fname = 'John', Minit = 'B', Lname = 'Smith')?
SELECT Bdate, Address FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

-- Quais os dados do departamento 'Research'?
select * from department where Dname = 'Research';

-- Quais os funcionários do departamento 'Research'?
SELECT Fname, Lname, Address, Dno
FROM employee, department
WHERE Dname = 'Research' AND Dnumber = Dno;

select * from project;

-- 2. Expressões e Concatenação de Strings:

-- Quais departamentos estão localizados em Stafford?
select Dname as Department, Mgr_ssn as Manager from department d, dept_locations l
where d.Dnumber = l.Dnumber;

-- Qual o nome e sobrenome (concatenados) dos funcionários que trabalham em Stafford?
select Dname as Department, concat(Fname, ' ', Lname) from department d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- Quais projetos estão localizados em Stafford?
select * from project, department where Dnum = Dnumber and Plocation = 'Stafford';

-- Quais funcionários trabalham nos departamentos 3 ou 8? (departamentos não existem)
SELECT * FROM employee WHERE Dno IN (3,8);

-- 3. Operadores lógicos

SELECT Bdate, Address
FROM EMPLOYEE
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

SELECT Fname, Lname, Address
FROM EMPLOYEE, DEPARTMENT
WHERE Dname = 'Research' AND Dnumber = Dno;

-- 4. Expressões e Alias

/* Calculando o valor do INSS */
select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, Salary*0.011 as INSS from employee;
select Fname, Lname, Salary, round(Salary*0.011,2) as INSS from employee;

/* Aumento de salário para funcionários que trabalham com ProductX */
select e.Fname, e.Lname, e.Salary as old_sal, 1.1*e.Salary as increased_sal from employee as e,
works_on as w, project as p where e.Ssn = w.Essn and w.Pno = p.Pnumber and p.Pname='ProductX';

/* Nome e Sobrenome (concatenados) dos managers e seus departamentos */
select Dname as Department, concat(Fname, ' ', Lname) as Manager from department d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

/* Alias para legibilidade da consulta */
select e.Fname, e.Lname, e.Address from employee e, department d
where d.Dname = 'Research' and d.Dnumber = e.Dno;