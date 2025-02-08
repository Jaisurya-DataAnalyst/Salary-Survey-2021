use milestone;

/*1.Average salary by Industry and Gender*/

select industry,gender, 
round(Avg(annual_salary),2) as Average_Salary
from salary_survey
group by industry,gender
order by industry,gender;

/*2.Total Salary Compensation by Job Title*/

select job_title ,
	sum(annual_salary+Additional_monetary_compensation)
    as Total_salary
    from Salary_survey
    group by job_title
    order by Total_salary Desc;

/*3.Salary Distribution by Education Level*/

select Highest_education ,
 round(avg(annual_salary),2) as Average_Salary ,
 max(annual_salary) as Maximum_salary ,
 min(annual_salary) as Minimum_salary
 from salary_survey
 group by Highest_education
 Order by Average_Salary desc;
 
 /*4.Number of Employees by Industry and Years of Experience*/
 
 select industry , Years_of_Professional_Experience_Overall , 
 count(*) as Employee_Count
 from Salary_survey
 group by industry, Years_of_Professional_Experience_Overall
 Order by industry, Years_of_Professional_Experience_Overall,
 employee_count desc;
 
/*5.Median Salary by Age Range and Gender*/

WITH RankedSalaries AS (
    SELECT 
        Age_range,
        Gender,
        Annual_Salary,
        ROW_NUMBER() OVER (PARTITION BY Age_range, Gender ORDER BY Annual_Salary) AS Row_Num,
        COUNT(*) OVER (PARTITION BY Age_range, Gender) AS Total_Count
    FROM Salary_Survey
)
SELECT 
    Age_range,
    Gender,
    Round(AVG(Annual_Salary),2) AS Median_Salary
FROM RankedSalaries
WHERE Row_Num IN (FLOOR((Total_Count + 1) / 2.0), CEIL((Total_Count + 1) / 2.0))
GROUP BY Age_range, Gender
ORDER BY Age_range, Gender;
 
 /*6.Job Titles with the Highest Salary in Each Country*/
 

WITH MaxSalaryPerCountry AS (
    SELECT Country, MAX(Annual_Salary) AS Max_Salary
    FROM Salary_Survey
    GROUP BY Country
)
SELECT S.Job_Title, S.Country, S.Annual_Salary AS Max_Salary
FROM Salary_Survey S
JOIN MaxSalaryPerCountry M
ON S.Country = M.Country AND S.Annual_Salary = M.Max_Salary
ORDER BY Max_Salary Desc, S.Country;


 /*7.Average Salary by City and Industry*/
 
 SELECT city,Industry, round(AVG(Annual_salary),2) AS average_salary
FROM salary_survey
GROUP BY city, industry
ORDER BY city, industry DESC;

/* 8. Percentage of Employees with Additional Monetary Compensation by Gender*/
SELECT 
    Gender,
    ROUND((COUNT(CASE WHEN Additional_Monetary_Compensation > 0 THEN 1 END) * 100.0) / COUNT(*), 2) 
    AS Percentage_with_Compensation
FROM 
    salary_survey
GROUP BY 
    Gender;

/*9.Total Compensation by Job Title and Years of Experience*/

SELECT 
    Job_Title, 
    Years_of_professional_Experience_overall, 
    SUM(annual_salary + COALESCE(Additional_Monetary_Compensation, 0)) AS Total_Compensation
FROM 
    salary_survey
GROUP BY 
    Job_Title,Years_of_professional_Experience_overall
ORDER BY 
    Job_Title,Years_of_professional_Experience_overall;


/*10.Average Salary by Industry, Gender, and Education Level*/

SELECT 
    Industry,
    Gender,
    Highest_Education,
    ROUND(AVG(Annual_Salary), 2) AS Average_Salary
FROM 
    salary_survey
GROUP BY 
    Industry, Gender, Highest_education
ORDER BY 
    Industry, Gender, Highest_education;



