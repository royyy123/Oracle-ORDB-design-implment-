set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Clean up database');
end;
/

drop table Employee;
drop table Department;
drop table Training;
drop table TrainingHistory;
drop table Job;
drop table JobHistory;
drop table Recruitment;
drop table Company;
drop table FTE;
drop table Contractor;
drop table PartTime;
drop type TrainingHistory_t;
drop type Recruitment_t;
drop type FTE_t;
drop type PartTime_t;
drop type Contractor_t;
drop type CompensationPlan_t;
drop type JobHistory_t;
drop type Job_t;
drop type Department_t;
drop type Company_t;
drop type Training_t;
drop type Employee_t;

set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Clean-up is done.');
end;
/

