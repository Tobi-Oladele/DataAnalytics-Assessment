# DataAnalytics-Assessment

 ✅ Question 1: Identify Customers with Savings and Investment Plans
 🎯 Objective
Identify users who have both savings and investment plans and calculate their total confirmed deposit across savings accounts.
  🧠 Approach
- Performed a `UNION ALL` between:
  - One query calculating deposits
  - One query counting plan types
- Grouped the results by user ID and name
- Filtered for customers with **at least one savings and one investment plan**
- Sorted by highest total deposits

✅  Question 2: Frequency of Transactions
🎯Objective
Classify users by how often they transact into High, Medium, or Low Frequency tiers.
🧠 Approach
Calculated monthly transaction frequency using total transactions / number of months active.
Used a CASE statement to assign a frequency category.
Grouped the results to count users and compute average transaction frequency per category.


✅ Question 3: Detect Inactive Accounts (No Inflow in 1 Year)
🎯 Objective
Identify all active users who haven’t made any inflow transactions in the last 365 days.
🧠 Approach
Created a CTE active_user from users marked is_active = 1.
Calculated the last transaction date per plan and computed days since last transaction.
Filtered for active users in the final result.


 ✅ Question 4: Customer Lifetime Value (CLV) Estimation
🎯 Objective
Estimate each user's potential lifetime value based on tenure and confirmed deposits.
🧠 Approach
Calculated tenure in months using TIMESTAMPDIFF().
Computed total deposits per user.
Estimated CLV as monthly average × 12 × conversion factor (0.001).

