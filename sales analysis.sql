-- EDA
Select * from customers limit 5
select * from orders limit 5
select * from salespersons
select * from states
select * from statuses
select * from categories

--check isnull
select * from customers
where customers isnull

select * from orders
where orders isnull

select * from salespersons
where salespersons isnull

select * from states
where states isnull

select * from statuses
where statuses isnull

select * from categories
where categories isnull

-- data analysis
--list top 3 products by revenue

select p.name as product_name , sum(o.revenue) as Revenue
from products as p inner join orders as o on p.id = o.product_id
group by p.name 
order by sum(o.revenue) desc
limit 3

--show top 3 months of the year by revenue

select extract(month from o.order_date) as month_in_numeric, sum(o.revenue) as revenue
from orders as o
group by month_in_numeric
order by revenue desc
limit 3

--show top 3 states where top 3 items are purchased in high quantity

select st.name as states 
from orders as o inner join customers as c on c.id = o.customer_id
inner join states as st on st.id = c.state_id
where o.product_id IN(
	select product_id from orders group by product_id order by sum (revenue) desc limit 3
)
group by states
order by sum (o.quantity) desc limit 3

--show which age group people generated more revenue in the top 3 states

select min(age),max(age)
from customers

select
case
	when c.age <= 30 then 'Young aged'
	when c.age between 30 and 50 then 'Middle aged'
	when c.age > 50 then 'Senior'
end as age_group,
sum (o.revenue) as Revenue
from orders  as o inner join customers as c on c.id = o.customer_id
where c.state_id IN (

	select st.id as states
	from orders as o 
	inner join customers as c on c.id = o.customer_id
	inner join states as st on st.id = c.state_id
	where o.product_id IN(
		select product_id from orders group by product_id order by sum (revenue) desc limit 3
	)
	group by states
	order by sum(o.quantity) desc limit 3
)
group by age_group
order by Revenue









