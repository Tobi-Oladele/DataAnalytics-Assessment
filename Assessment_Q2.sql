USE adashi_staging;

-- Creating a CTE to categorize users based on transaction frequency
WITH categorized_users AS (
    SELECT 
        u.id,  -- User ID
        CONCAT(u.first_name, ' ', u.last_name) AS name,  -- Concatenating first name and last name to form full name

        -- Calculating the average number of transactions per month
        COUNT(s.owner_id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) AS average_count,

        -- Categorizing users based on their transaction frequency
        CASE 
            -- High Frequency: More than or equal to 10 transactions per month
            WHEN COUNT(s.owner_id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) >= 10 THEN 'High Frequency'
            -- Medium Frequency: Between 3 and 9 transactions per month
            WHEN COUNT(s.owner_id) / COUNT(DISTINCT DATE_FORMAT(s.transaction_date, '%Y-%m')) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            -- Low Frequency: Fewer than 3 transactions per month
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM users_customuser u 
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY u.id, u.first_name, u.last_name
)

-- Final query to summarize the categorized users based on frequency category
SELECT
    frequency_category,  
    COUNT(*) AS customer_count,  -- Count of users in each frequency category
    ROUND(AVG(average_count), 1) AS avg_transactions_per_month  -- Average transactions per month per category, rounded to 1 decimal place
FROM categorized_users
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
