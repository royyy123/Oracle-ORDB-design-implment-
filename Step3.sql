set serveroutput on format wrapped;
--1 Find titles of the jobs hired by the company ‘Meridian’ with the base salary greater than 80,000.00.
begin
    DBMS_OUTPUT.put_line('1 Find titles of the jobs hired by the company Meridian with the base salary greater than 80,000.00.');
end;
/
select f.jobtitle From FTE f where f.doid.coid.companyname='Meridian' and f.cp.BaseSalary>'80000';
--2 List all employee information in ‘Tutor’ department
begin
    DBMS_OUTPUT.put_line('2 List all employees information in Tutor department.');
end;
/
Select e.EmployeeID, e.getFullName(), e.getAge(),e.SIN,e.Gender From employee e;
--3 List all employee names who have not passed or taken Safety Training.
begin
    DBMS_OUTPUT.put_line('3 List all employee names who has not passed or taken Safety Training.');
end;
/
Select th.eoid.getFullName() From TrainingHistory th Where th.isPassed()=0 and th.toid.trainingtitle = 'Safety training';
select e.getfullname() from Employee e where e.employeeid not in (select th.eoid.EmployeeID from TrainingHistory th);
--4 List how many months employee Emma has worked in different positions.
begin
    DBMS_OUTPUT.put_line('4 List how many months employee Emma has worked in different positions.');
end;
/
select jh.eoid.getFullName(), jh.joid.jobtitle, jh.getWorkMonth() from jobhistory jh where jh.eoid.FirstN='Emma';
--5 List employees whose rank are above 10, order from lowest to highest.
begin
    DBMS_OUTPUT.put_line('5 List employees whose rank are above 10, order from lowest to highest.');
end;
/
select e.getFullName(), f.Rank
from FTE f, Employee e, JobHistory jh
where f.JobID=deref(jh.joid).JobID 
and e.EmployeeID=deref(jh.eoid).EmployeeID
order by value(f)
;

--6 List full time employees total income, order them from the highest to the lowest.
begin
    DBMS_OUTPUT.put_line('6 List full time employees total income, order them from the highest to the lowest.');
end;
/
select e.getFullName(), f.cp.calculateCP()
from FTE f, Employee e, JobHistory jh
where JobID=deref(jh.joid).JobID 
and e.EmployeeID=deref(jh.eoid).EmployeeID
and jh.EndDate is null
order by f.cp.calculateCP() desc
;
--7 List job titles of ongoing recruitments
begin
    DBMS_OUTPUT.put_line('7 List job titles of ongoing recruitments.');
end;
/
select r.RecruitmentID, JobTitle
from ( 
select f.JobID, f.JobTitle from FTE f
union select ct.JobID, ct.JobTitle from Contractor ct
union select p.JobID, p.JobTitle from PartTime p
), recruitment r
where deref(r.joid).JobID=JobID
and r.isexpired()=0
order by r.RecruitmentID asc
;
--8 List ongoing recruitments which have listed longer than 100 days.
begin
    DBMS_OUTPUT.put_line('8 List ongoing recruitments which have listed longer than 100 days.');
end;
/
select r.RecruitmentID, JobTitle, r.listedDays()
from (
select f.JobID, f.JobTitle from FTE f
union select ct.JobID, ct.JobTitle from Contractor ct
union select p.JobID, p.JobTitle from PartTime p
), recruitment r
where deref(r.joid).JobID=JobID
and r.listedDays()>100
and r.isexpired()=0
order by r.RecruitmentID asc
;
--9 List all the non-full-time employees and their weekly salary.
begin
    DBMS_OUTPUT.put_line('9 List all the non-full-time employees and their weekly salary.');
end;
/
select e.getFullName(), treat(jh.joid as ref Contractor_t).calWeeklySalary() as WeeklySalary
from JobHistory jh, Employee e
where e.EmployeeID=deref(jh.eoid).EmployeeID
and jh.EndDate is null
;
--10 List sales department employees who have resigned in the year of 2019.
begin
    DBMS_OUTPUT.put_line('10 List sales department employees who have resigned in the year of 2019.');
end;
/
select e.getFullName(), JobTitle, jh.EndDate
from (
select f.JobID, f.JobTitle, deref(f.doid).DepartmentName as DepartmentName from FTE f
union select ct.JobID, ct.JobTitle, deref(ct.doid).DepartmentName as DepartmentName from Contractor ct
union select p.JobID, p.JobTitle, deref(p.doid).DepartmentName as DepartmentName from PartTime p
), Employee e, JobHistory jh
where jh.EndDate>='01-JAN-19' 
and jh.EndDate<='31-DEC-19'
and e.EmployeeID=deref(jh.eoid).EmployeeID
and JobID=deref(jh.joid).JobID
and DepartmentName='Sales'
;

--11 List all the trainings that Tommy Henry had taken in the past 2 years.
begin
    DBMS_OUTPUT.put_line('11 List all the trainings that Tommy Henry had taken in the past 2 years.');
end;
/

select e.getFullName(), t.TrainingTitle, th.TrainingDate
from TrainingHistory th, Training t, Employee e
where e.EmployeeID=deref(th.eoid).EmployeeID
and t.TrainingID=deref(th.toid).TrainingID
and th.TrainingDate>=trunc(SYSDATE - interval '2' year)
and e.getFullName()='Tommy Henry'
;



