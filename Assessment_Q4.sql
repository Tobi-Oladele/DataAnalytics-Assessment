USE adashi_staging;

SELECT 
    u.id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH,
        u.date_joined,
        CURDATE()) AS tenure_months,
    SUM(s.confirmed_amount) AS total_transactions,
    IF(TIMESTAMPDIFF(MONTH,
            u.date_joined,
            CURDATE()) = 0,
        0,
        (SUM(s.confirmed_amount) / TIMESTAMPDIFF(MONTH,
            u.date_joined,
            CURDATE())) * 12 * 0.001) AS estimated_clv
FROM
    users_customuser u
        JOIN
    savings_savingsaccount s ON u.id = s.owner_id
GROUP BY u.id , u.first_name , u.last_name , u.date_joined;

