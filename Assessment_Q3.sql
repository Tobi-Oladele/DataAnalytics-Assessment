USE adashi_staging;

-- CTE to get the active users 
WITH active_user AS (
    SELECT id 
    FROM users_customuser  
    WHERE is_active = 1 
),

-- CTE to get information about plans and their last transaction date
sub AS (
    SELECT 
        p.id AS plan_id, 
        p.owner_id,
        -- Determining the type of the plan: 'Investments' if it's a fund, otherwise 'Savings'
        CASE 
            WHEN p.is_a_fund = 1 THEN 'Investments'
            ELSE 'Savings'
        END AS type,
        
        -- Getting the most recent transaction date for each plan
        MAX(s.transaction_date) AS last_transaction_date, 
        
        -- Calculating the inactivity days: difference between the current date and the last transaction date
        DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) AS inactivity_day
        
    FROM 
        plans_plan p 
    JOIN 
        savings_savingsaccount s  
        ON p.id = s.plan_id 
    GROUP BY 
        plan_id, p.owner_id 
)

-- Final query to get the plan details for active users only
SELECT * 
FROM sub  -- From the 'sub' CTE that contains plan and transaction information
WHERE owner_id IN (SELECT id FROM active_user)  -- Filter for only active users (whose ID is in the active_user CTE)
;