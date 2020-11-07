create or replace type Employee_t as object( EmployeeID char(6), FirstN varchar2(10), LastN  varchar2(10),DoB date, SIN char(9), Gender char(1), member function getAge return varchar2, member function getFullName return varchar2); 
/
create or replace type Training_t as object(TrainingID char(4), TrainingTitle varchar2(30), TrainingCategory varchar2(30), TrainingHour number);
/
create or replace type TrainingHistory_t as object(TrainingHistoryID char(6), TrainingDate Date, TrainingScore number, toid ref Training_t, eoid ref Employee_t, member function isPassed return INTEGER);
/
create or replace type Company_t as object (CompanyID char(4), CompanyName varchar2(30));
/
create or replace type Department_t as object (DepartmentID char(4), DepartmentName varchar2(30), coid ref Company_t);
/
create or replace type Job_t as object (JobID char(6), JobTitle varchar2(30), Rank INTEGER, doid ref Department_t, order member function compareRank(j job_t) return integer, NOT INSTANTIABLE member function calWeeklySalary(workhours NUMBER) return number) NOT INSTANTIABLE NOT FINAL;
/
create or replace type CompensationPlan_t as object (CompensationPlanID char(6), BaseSalary number,  Bonus number, member function calculateCP return number);
/
create or replace type FTE_t under Job_t (cp CompensationPlan_t, overriding member function calWeeklySalary(workhours NUMBER) return number); 
/
create or replace type Contractor_t under Job_t( HourlyRate Number, overriding member function calWeeklySalary(workhours NUMBER) return number); 
/
create or replace type PartTime_t under Job_t(HourlyRate Number,  overriding member function calWeeklySalary(workhours NUMBER) return number);
/
create or replace type JobHistory_t as object (JobHistoryID char(6), StartDate date, EndDate date, eoid ref Employee_t, joid ref Job_t, map member function getWorkMonth return varchar2);
/
create or replace type Recruitment_t as object (RecruitmentID char(6), ListDate date, ExpireDate Date, joid ref Job_t, member function isExpired return INTEGER, member function listedDays return INTEGER);
/


CREATE OR REPLACE TYPE BODY employee_t AS
MEMBER FUNCTION getage RETURN VARCHAR2 IS
BEGIN
RETURN TRUNC((SYSDATE-dob)/365);
END;
MEMBER FUNCTION getfullname RETURN VARCHAR2 IS
BEGIN
RETURN self.FirstN||' '||self.LastN;
END;
END;
/

CREATE OR REPLACE TYPE BODY jobhistory_t AS
MAP MEMBER FUNCTION getworkmonth RETURN VARCHAR2 IS
BEGIN
IF SELF.ENDDATE is NULL THEN
	RETURN TRUNC((SYSDATE - self.startdate)/30);
ELSE
	RETURN TRUNC((self.enddate - self.startdate)/30);
END IF;
END;
END;
/


CREATE OR REPLACE TYPE BODY job_t AS
ORDER MEMBER FUNCTION comparerank (j job_t) RETURN INTEGER IS
BEGIN
IF self.rank < j.rank THEN
RETURN -1;
ELSIF self.rank > j.rank THEN
RETURN 1; 
ELSE
RETURN 0;
END IF;
END;
END;
/

CREATE OR REPLACE TYPE BODY contractor_t AS
OVERRIDING MEMBER FUNCTION calWeeklySalary (workhours NUMBER) RETURN NUMBER IS
BEGIN
RETURN (HourlyRate * workhours);
END;
END;
/

CREATE OR REPLACE TYPE BODY PartTime_t AS
OVERRIDING MEMBER FUNCTION calWeeklySalary (workhours NUMBER) RETURN NUMBER IS
BEGIN
RETURN (HourlyRate * workhours);
END;
END;
/


CREATE OR REPLACE TYPE BODY TrainingHistory_t AS
MEMBER FUNCTION isPassed RETURN INTEGER IS
BEGIN
IF self.TrainingScore >= 60 THEN
RETURN -1;
ELSE
RETURN 0;
END IF;
END;
END;
/

CREATE OR REPLACE TYPE BODY Recruitment_t AS
MEMBER FUNCTION isExpired RETURN INTEGER IS
BEGIN
IF (SYSDATE - expireDate) > 0 THEN
RETURN 1;
ELSE 
RETURN 0;
END IF;
END;

MEMBER FUNCTION listedDays RETURN INTEGER IS
BEGIN
RETURN (SYSDATE - ListDate);
END;
END;
/

CREATE OR REPLACE TYPE BODY CompensationPlan_t AS
MEMBER FUNCTION calculateCP RETURN NUMBER IS
BEGIN
RETURN (BaseSalary + Bonus);
END;
END;
/

CREATE TABLE Employee OF Employee_t(PRIMARY KEY(EmployeeID), FirstN NOT NULL, LastN NOT NULL, DoB NOT NULL);

CREATE TABLE Department OF Department_t(PRIMARY KEY(DepartmentID), DepartmentName NOT NULL);

CREATE TABLE Training OF Training_t(PRIMARY KEY(TrainingID));

CREATE TABLE TrainingHistory OF TrainingHistory_t(PRIMARY KEY(TrainingHistoryID));

CREATE TABLE JobHistory OF JobHistory_t(PRIMARY KEY(JobHistoryID));

CREATE TABLE Recruitment OF Recruitment_t(PRIMARY KEY(RecruitmentID));

CREATE TABLE Company OF Company_t(PRIMARY KEY(CompanyID), CompanyName NOT NULL);

CREATE TABLE FTE OF FTE_t;

CREATE TABLE Contractor OF Contractor_t;

CREATE TABLE PartTime OF PartTime_t;







