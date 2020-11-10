
INSERT INTO Employee VALUES (Employee_t('E00001','Carter','Ned','31-Mar-1975','256489341','M'));
INSERT INTO Employee VALUES (Employee_t('E00002','Tommy','Henry','21-Aug-1987','286492583','M'));
INSERT INTO Employee VALUES (Employee_t('E00003','June','Malone','31-Mar-1985','378941527','F'));
INSERT INTO Employee VALUES (Employee_t('E00004','Emma','Glisson','31-Mar-1995','468791352','F'));

INSERT INTO Training VALUES (Training_t('T001','Sales training','Sales','2'));
INSERT INTO Training VALUES (Training_t('T002','IT training','IT','1'));
INSERT INTO Training VALUES (Training_t('T003','Safety training','Safety and Health Affairs','3'));

INSERT INTO TrainingHistory VALUES (TrainingHistory_t('TH0001', '31-Mar-2020','70',(SELECT REF(t) FROM Training t WHERE t.TrainingID = 'T003'), (SELECT REF(e) FROM Employee e WHERE e.employeeid = 'E00001')));
INSERT INTO TrainingHistory VALUES (TrainingHistory_t('TH0002', '31-Mar-2020','90',(SELECT REF(t) FROM Training t WHERE t.TrainingID = 'T002'), (SELECT REF(e) FROM Employee e WHERE e.employeeid = 'E00002')));
INSERT INTO TrainingHistory VALUES (TrainingHistory_t('TH0003', '31-Mar-2020','40',(SELECT REF(t) FROM Training t WHERE t.TrainingID = 'T003'), (SELECT REF(e) FROM Employee e WHERE e.employeeid = 'E00002')));
INSERT INTO TrainingHistory VALUES (TrainingHistory_t('TH0004', '31-Mar-2020','100',(SELECT REF(t) FROM Training t WHERE t.TrainingID = 'T001'), (SELECT REF(e) FROM Employee e WHERE e.employeeid = 'E00004')));
INSERT INTO TrainingHistory VALUES (TrainingHistory_t('TH0005', '31-Mar-2020','100',(SELECT REF(t) FROM Training t WHERE t.TrainingID = 'T003'), (SELECT REF(e) FROM Employee e WHERE e.employeeid = 'E00004')));

Insert into company values (company_t('C001', 'BestIT')); 
Insert into company values (company_t('C002', 'Meridian')); 
Insert into company values (company_t('C003', 'GPAplus')); 
 
Insert into department values (department_t('D001', 'IT', (select ref(c) from company c where c.companyID ='C001'))); 
Insert into department values (department_t('D002', 'Tutor', (select ref(c) from company c where c.companyID ='C002'))); 
Insert into department values (department_t('D003', 'Sales', (select ref(c) from company c where c.companyID ='C003'))); 
Insert into department values (department_t('D004', 'Marking', (select ref(c) from company c where c.companyID ='C003')));


INSERT INTO PartTime VALUES(PartTime_t('J00301','Summer Internship', 2,(SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D002'),15));
INSERT INTO PartTime VALUES(PartTime_t('J00302','Sales Representative', 4, (SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D003'),18));
INSERT INTO PartTime VALUES(PartTime_t('J00303','Marking', 3, (SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D003'),20));

INSERT INTO Contractor VALUES(Contractor_t('J00201','Network Administrator',4,(SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D001'),18));
INSERT INTO Contractor VALUES(Contractor_t('J00202','IT Helpdesk',4,(SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D001'),18));
INSERT INTO Contractor VALUES(Contractor_t('J00203','Course Content Writer',4,(SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D002'),20));

INSERT INTO FTE VALUES(FTE_t('J00101','Math Tutor', 11,(SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D002'),CompensationPlan_t('C00101','70000','10000')));
INSERT INTO FTE VALUES(FTE_t('J00102','IT Tutor', 10,(SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D002'),CompensationPlan_t('C00102','90000','20000')));
INSERT INTO FTE VALUES(FTE_t('J00103','Math Tutor', 11,(SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D002'),CompensationPlan_t('C00103','95000','20000')));
INSERT INTO FTE VALUES(FTE_t('J00104','IT Tutor', 10, (SELECT REF(d) FROM Department d WHERE d.DepartmentID = 'D002'),CompensationPlan_t('C00104','60000','10000')));

INSERT INTO JobHistory VALUES(JobHistory_t('JH0001','01-Jan-2015', NULL, (SELECT REF(e) FROM Employee e WHERE e.EmployeeID = 'E00001'), (SELECT REF(ct) FROM Contractor ct WHERE ct.JobID = 'J00202')));
INSERT INTO JobHistory VALUES(JobHistory_t('JH0002','01-Jan-2019', NULL, (SELECT REF(e) FROM Employee e WHERE e.EmployeeID = 'E00002'), (SELECT REF(f) FROM FTE f WHERE f.JobID = 'J00101')));
INSERT INTO JobHistory VALUES(JobHistory_t('JH0003','01-Jan-2019', NULL, (SELECT REF(e) FROM Employee e WHERE e.EmployeeID = 'E00003'), (SELECT REF(f) FROM FTE f WHERE f.JobID = 'J00102')));
INSERT INTO JobHistory VALUES(JobHistory_t('JH0005','01-Jan-2020', NULL, (SELECT REF(e) FROM Employee e WHERE e.EmployeeID = 'E00004'), (SELECT REF(f) FROM FTE f WHERE f.JobID = 'J00103')));
INSERT INTO JobHistory VALUES(JobHistory_t('JH0004','31-Mar-2019', '31-Dec-2019', (SELECT REF(e) FROM Employee e WHERE e.EmployeeID = 'E00004'), (SELECT REF(p) FROM PartTime p WHERE p.JobID = 'J00302')));

 
Insert into recruitment values (recruitment_t('R00001','01-Sep-2014', '20-Dec-2014',  (select ref(ct) from Contractor ct where ct.jobID='J00202'))); 
Insert into recruitment values (recruitment_t('R00002','11-Apr-2018', '10-Dec-2018',  (select ref(f) from FTE f where f.jobID='J00101'))); 
Insert into recruitment values (recruitment_t('R00003','11-Apr-2018', '10-Dec-2018',  (select ref(f) from FTE f where f.jobID='J00102')));
Insert into recruitment values (recruitment_t('R00004','01-Mar-2019', '15-Mar-2019',  (select ref(p) from PartTime p where p.jobID='J00302')));
Insert into recruitment values (recruitment_t('R00005','01-Dec-2019', '21-Dec-2019',  (select ref(f) from FTE f where f.jobID='J00103')));
Insert into recruitment values (recruitment_t('R00006','30-Jul-2020', '01-Dec-2020',  (select ref(f) from FTE f where f.jobID='J00104')));
Insert into recruitment values (recruitment_t('R00007','01-Apr-2020', '01-Dec-2020',  (select ref(p) from PartTime p where p.jobID='J00303')));
Insert into recruitment values (recruitment_t('R00008','01-Sep-2020', '01-Dec-2020',  (select ref(p) from PartTime p where p.jobID='J00303')));
 

