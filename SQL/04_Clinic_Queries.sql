
-- Q1. Find the revenue we got from each sales channel n a given year

select sales_channel,sum(amount) as total_amount from clinic_sales group by sales_channel;


-- Q2. Find top 10 most valuable customers for a given year

with s as (select c.name,sum(amount) as total_amount from clinic_sales cs
left join customer c on cs.uid = c.uid
group by c.name )
select name from s order by total_amount desc limit 10;



-- Q3. Month-wise revenue, expense, profit, and status (Profitable / Not-Profitable) for a given year


with r as (select strftime("%m",datetime) as month,sum(amount) as revenue from clinic_sales
group by strftime("%m",datetime)
),
e as (select strftime("%m",datetime) as month,sum(amount) as expense from expenses
group by strftime("%m",datetime)
)

select r.month,r.revenue,e.expense,r.revenue - e.expense as profit, 
case when r.revenue - e.expense < 0 then 'not-profitable' 
     when r.revenue - e.expense >= 0 then 'profitable' end as status 

	 from r 
     left join e on r.month = e.month;



-- Q4. For each city, find the most profitable clinic for a given month


with r as (select c.clinic_name,c.city,sum(cs.amount) as revenue from clinic_sales cs
left join clinics c on cs.cid = c.cid
group by c.clinic_name,c.city
),
e as (select c.clinic_name,c.city,sum(amount) as expense from expenses e
left join clinics c on e.cid = c.cid
group by c.clinic_name,c.city
),

p as (select r.clinic_name,r.city,r.revenue - e.expense as profit, row_number()over(partition by r.city order by r.revenue - e.expense desc) as rnk


	 from r 
	 left join e on r.clinic_name = e.clinic_name and r.city = e.city)

	 select p.city,p.clinic_name from p where p.rnk = 1;

-- Q5. For each state, find the second least profitable clinic for a given month

with r as (select c.clinic_name,c.state,sum(cs.amount) as revenue from clinic_sales cs
left join clinics c on cs.cid = c.cid
group by c.clinic_name,c.state
),
e as (select c.clinic_name,c.state,sum(amount) as expense from expenses e
left join clinics c on e.cid = c.cid
group by c.clinic_name,c.state
),

p as (select r.clinic_name,r.state,r.revenue - e.expense as profit, row_number()over(partition by r.state order by r.revenue - e.expense asc) as rnk


	 from r 
	 left join e on r.clinic_name = e.clinic_name and r.state = e.state)

	 select p.state,p.clinic_name from p where p.rnk = 2;
