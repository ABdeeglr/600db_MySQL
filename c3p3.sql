USE sql_hr;

SELECT Concat(main.first_name, " ", main.last_name) AS staff,
       main.job_title,
       Concat(mirror.first_name, " ", mirror.last_name) AS boss
FROM employees main
JOIN employees mirror
	ON main.reports_to = mirror.employee_id;
