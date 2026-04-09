

-- Q1. For every user in the system, get the user_id and last booked room_no

SELECT b.user_id, b.room_no
FROM bookings b
INNER JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking_date
    FROM bookings
    GROUP BY user_id
) latest
ON  b.user_id      = latest.user_id
AND b.booking_date = latest.last_booking_date;



-- Q2. Get booking_id and total billing amount of every booking created in November 2021

with s as (select b.booking_id,b.booking_date,bc.item_quantity*i.item_rate as total_amount 
from bookings b
left join booking_commercials bc on b.booking_id = bc.booking_id 
left join items  i on bc.item_id = i.item_id
where strftime('%Y', bc.bill_date) = '2021'
      AND strftime('%m', bc.bill_date) = '11'
)
select s.booking_id,sum(s.total_amount) from s group by s.booking_id;


-- Q3. Get bill_id and bill amount of all bills raised in October 2021 having bill amount > 1000




with s as (select bc.bill_id,bc.item_quantity*i.item_rate as bill_amount 
from  booking_commercials bc 
left join items  i on bc.item_id = i.item_id
where strftime('%Y', bc.bill_date) = '2021'
      AND strftime('%m', bc.bill_date) = '10')
select s.bill_id,sum(bill_amount) as bill_amount from s group by s.bill_id having sum(bill_amount) > 1000;



-- Q4. Determine the most ordered and least ordered item of each month of year 2021

WITH s AS (
    SELECT 
        strftime('%Y-%m', b.booking_date) AS order_month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_count
    FROM bookings b
    LEFT JOIN booking_commercials bc 
        ON b.booking_id = bc.booking_id
    WHERE strftime('%Y', b.booking_date) = '2021'
    GROUP BY order_month, bc.item_id
),

rnk AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY order_month 
            ORDER BY total_count DESC
        ) AS max_rank,
        ROW_NUMBER() OVER (
            PARTITION BY order_month 
            ORDER BY total_count ASC
        ) AS min_rank
    FROM s
)

SELECT 
    r1.order_month,
    r1.item_id AS most_ordered,
    r2.item_id AS least_ordered
FROM rnk r1
JOIN rnk r2 
    ON r1.order_month = r2.order_month
WHERE r1.max_rank = 1
  AND r2.min_rank = 1;


-- Q5. Find the customers with the second highest bill value of each month of year 2021

WITH s AS (
    SELECT 
        b.user_id,
        strftime('%Y-%m', bc.bill_date) AS bill_month,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    LEFT JOIN bookings b 
        ON bc.booking_id = b.booking_id
    LEFT JOIN items i 
        ON bc.item_id = i.item_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY b.user_id, bill_month
),

rnk AS (
    SELECT 
        user_id,
        bill_month,
        bill_amount,
        ROW_NUMBER() OVER (
            PARTITION BY bill_month 
            ORDER BY bill_amount DESC
        ) AS rnk
    FROM s
)

SELECT 
    bill_month,
    user_id AS second_highest
FROM rnk
WHERE rnk = 2;