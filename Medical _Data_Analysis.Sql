CREATE DATABASE medical_data_analysis;
USE medical_data_analysis;

SELECT * FROM patients;
RENAME TABLE `patients (1)` TO patients;
SELECT * FROM patients;
SELECT * FROM admission;
SELECT * FROM doctors;
SELECT * FROM province_names;

SHOW TABLES;

-- Show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

-- Show first name and last name of patients who does not have allergies.
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;

-- Show first name of patients that start with the letter 'C'
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name, last_name, weight
FROM patients
WHERE weight BETWEEN 100 AND 120;

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
 SELECT *
FROM patients
WHERE allergies IS NULL;

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

SELECT first_name, last_name, allergies
FROM patients;

-- Show first name and last name concatenated into one column to show their full name
SELECT 
CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Show first name, last name, and the full province name of each
SELECT p.first_name,p.last_name,pn.province_name
FROM patients p
JOIN province_names pn ON p.province_id = pn.province_id;

-- Show how many patients have a birth_date with 2010 as the birth year
SELECT COUNT(*) AS patients_born_2010
FROM patients
WHERE YEAR(birth_date) = 2010;

-- Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name,  last_name,  height first_name,  last_name, height FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT * from patients where patient_id in (1,45,534,879,1000);

-- Show the total number of admissions
SELECT COUNT(*) AS total_admissions from admission;

-- Show all the columns from admissions where the patient was admitted & discharge on the same day.
SELECT * from admission where admission_date = discharge_date;

-- Show the total number of admissions for patient_id 579.
SELECT COUNT(*) AS total_admissions from admission 
WHERE patient_id = 579; 

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT city from patients
WHERE province_id = 'NS';

-- Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
 SELECT first_name, last_name,birth_date FROM patients
WHERE height > 160 AND weight > 70;

-- Show unique birth years from patients and order them by ascending.
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients ORDER BY birth_year ASC;

-- Show unique first names from the patients table which only occurs once in the list.
SELECT first_name from patients group by first_name
HAVING COUNT(*) = 1;

-- Show patient_id and first_name from patients where their first_name start & ends with 's' & is at least 6 characters long.
SELECT patient_id, first_name from patients where first_name like 's%s'
AND LENGTH(first_name) >= 6;

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'dementia'. primary diagnosis is stored in the admissions table.
SELECT p.patient_id,p.first_name,p.last_name FROM patients p JOIN admission a
ON p.patient_id = a.patient_id WHERE a.diagnosis = 'Dementia';

-- Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
SELECT first_name FROM patients ORDER BY LENGTH(first_name), first_name;

-- Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
SELECT SUM(gender = 'M') AS male_patients,  SUM(gender = 'F') AS female_patients
FROM patients;

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis FROM admission
GROUP BY patient_id, diagnosis HAVING COUNT(*) > 1;

-- Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
SELECT city, COUNT(*) AS total_patients FROM patients
GROUP BY city ORDER BY total_patients DESC, city ASC;

-- Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS role FROM patients
UNION SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

-- Show all allergies ordered by popularity. Remove NULL values from query.
SELECT allergies, COUNT(*) AS total_patients FROM patients
WHERE allergies IS NOT NULL GROUP BY allergies
ORDER BY total_patients DESC;

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date FROM patients
WHERE birth_date >= '1970-01-01' AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;

-- Show last name in uppercase, first name in lowercase, separated by a comma. Order by first name descending.
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients ORDER BY first_name DESC;

-- Show province IDs where the total height is at least 7000.
SELECT province_id, SUM(height) AS total_height
FROM patients GROUP BY province_id HAVING SUM(height) >= 7000;

-- Find the difference between the maximum and minimum weight for patients with last name Maroni.
SELECT MAX(weight) - MIN(weight) AS weight_difference FROM patients
WHERE last_name = 'Maroni'; 

-- Show admission counts for each day of the month, ordered from most to least admissions.
SELECT DAY(admission_date) AS day_of_month,
COUNT(*) AS total_admissions FROM admission
GROUP BY DAY(admission_date) ORDER BY total_admissions DESC;

-- Group patients into weight groups of ten, in descending order.
SELECT FLOOR(weight / 10) * 10 AS weight_group, COUNT(*) AS total_patients
FROM patients GROUP BY FLOOR(weight / 10) * 10
ORDER BY weight_group DESC;

-- Show patient ID, weight, height, and obesity status as 0 or 1.
SELECT  patient_id, weight,  height,
CASE WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1 ELSE 0
END AS isObese FROM patients;

-- Show patients diagnosed with Epilepsy whose attending doctor's first name is Lisa. Display the doctor's specialty.
SELECT p.patient_id, p.first_name, p.last_name, d.specialty FROM patients p
JOIN admission a ON p.patient_id = a.patient_id JOIN doctors d
ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
AND d.first_name = 'Lisa';










 
