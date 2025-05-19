USE adashi_staging;

SELECT 
    u.id AS id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    SUM(CASE
        WHEN p.is_a_fund != 1 THEN 1
        ELSE 0
    END) AS total_savings,
    SUM(CASE
        WHEN p.is_a_fund = 1 THEN 1
        ELSE 0
    END) AS total_investment,
    COALESCE(s.total_deposit, 0) AS total_deposit
FROM
    users_customuser u
        LEFT JOIN
    (SELECT 
        owner_id, SUM(confirmed_amount) AS total_deposit
    FROM
        savings_savingsaccount
    GROUP BY owner_id) s ON u.id = s.owner_id
        LEFT JOIN
    plans_plan p ON u.id = p.owner_id
GROUP BY u.id , u.first_name , u.last_name
HAVING total_savings > 0
    AND total_investment > 0
ORDER BY total_deposit DESC;
