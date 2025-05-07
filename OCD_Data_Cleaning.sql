create database ocd_db;

select *from ocd_patient limit 20;
select count(*) from ocd_patient;
describe ocd_patient;


alter table ocd_patient
modify column medications varchar(100);

alter table ocd_patient
modify column gender varchar(10);

alter table ocd_patient
modify column ethnicity varchar(50);

alter table ocd_patient
modify column `Marital Status` varchar(50);

alter table ocd_patient
modify column `Education Level` varchar(50);

alter table ocd_patient
modify column `OCD Diagnosis Date` date;

alter table ocd_patient
modify column `Previous Diagnoses` varchar(20);

alter table ocd_patient
modify column `Family History of OCD` varchar(10);

alter table ocd_patient
modify column `Obsession Type` varchar(50);

alter table ocd_patient
modify column `Compulsion Type` varchar(30);

alter table ocd_patient
modify column `Depression Diagnosis` varchar(10);

alter table ocd_patient
modify column `Anxiety Diagnosis` varchar(10);

-- checking if any duplicates
select `patient ID`, count(*)
	from ocd_patient
    group by `Patient ID`
    having count(*) > 1;
    
-- Adding a column y_bocs_obsession_range
with cte as
		(
        select `Y-BOCS Score (Obsessions)`, 
			case
				when `Y-BOCS Score (Obsessions)` between 0 and 7 then 'Subclinical or mild OCD symptoms'
				when `Y-BOCS Score (Obsessions)` between 8 and 15 then 'Mild OCD symptoms'
				when `Y-BOCS Score (Obsessions)` between 16 and 23 then 'Moderate OCD symptoms'
				when `Y-BOCS Score (Obsessions)` between 24 and 31 then 'Severe OCD symptoms'
				else 'Extreme OCD symptoms'
				end as y_bocs_obsession_range
from ocd_patient)
select  * from cte;

-- creating a new table with new columns added(y_bocs_obsession_range and y_bocs_compulsion_range)
create table OCD_Patient_Cleaned_Dataset
as
with cte as
	(
        select  `Patient ID` as patient_id,
		 Age,
                 gender,
                 ethnicity,
                 `Marital Status` as marital_status,
                 `Education Level` as education_level,
                 `OCD Diagnosis Date` as OCD_diagnosis_date,
                 `Duration of Symptoms (months)` as Duration_of_Symptoms_months,
                 `Previous Diagnoses` as previous_diagnosis,
                 `Family History of OCD` as family_history_Of_OCD,
                 `Obsession Type` as obsession_type,
                 `Compulsion Type` as compulsion_type,
                 `Y-BOCS Score (Obsessions)` as Y_BOCS_Score_Obsessions,
            	     case
			 when `Y-BOCS Score (Obsessions)` between 0 and 7 then 'Subclinical or mild OCD symptoms'
			 when `Y-BOCS Score (Obsessions)` between 8 and 15 then 'Mild OCD symptoms'
			 when `Y-BOCS Score (Obsessions)` between 16 and 23 then 'Moderate OCD symptoms'
			 when `Y-BOCS Score (Obsessions)` between 24 and 31 then 'Severe OCD symptoms'
			 else 'Extreme OCD symptoms'
			 end as y_bocs_obsession_score_range,
		 Y-BOCS Score (Compulsions)` as Y_BOCS_Score_Compulsions ,
            	     case
			when `Y-BOCS Score (Compulsions)` between 0 and 7 then 'Mild OCD or None'
			when `Y-BOCS Score (Compulsions)` between 8 and 15 then 'Mild OCD symptoms'
			when `Y-BOCS Score (Compulsions)` between 16 and 23 then 'Moderate OCD symptoms'
			when `Y-BOCS Score (Compulsions)` between 24 and 31 then 'Severe OCD symptoms'
			else 'Extreme OCD symptoms'
			end as y_bocs_compulsion_score_range,
		`Depression Diagnosis` as depression_diagnosis,
                `Anxiety Diagnosis` as anxiety_diagnosis,
                 medications
from ocd_patient)
select  * from cte;

select * from ocd_patient_cleaned_data;







