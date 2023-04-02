USE sql_hr;

SELECT
    main.employee_id,
    main.first_name,
    sub.first_name AS manager
FROM employees main
LEFT JOIN employees sub
    ON main.reports_to = sub.employee_id;
