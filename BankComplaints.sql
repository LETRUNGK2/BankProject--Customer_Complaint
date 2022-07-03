--I. Identify common issues and its related product
-- Identify top 15 issues and sub_issues? 
select top 15 issue,count(issue) as count_issue 
from ConsumerComplaints
group by issue
order by count_issue desc 

select top 15 sub_issue,issue,count(sub_issue) as count_sub_issue
from ConsumerComplaints
group by sub_issue,issue  
order by count_sub_issue desc

-- what are percentage of top 15 issues got disputed?
with temp1 as (
	select issue,count(issue) as disputed 
	from ConsumerComplaints
	where consumer_disputed = 'yes' 
	group by issue),

	temp2 as (
	select issue,count(issue) as total_issue 
	from ConsumerComplaints 
	group by issue)

select top 15 t1.issue,t1.disputed, t2.total_issue,
	concat(round(try_convert(float,t1.disputed)/try_convert(float,t2.total_issue),4) * 100,'%')
	as Percentage_dispute
	from temp2 t2 join temp1 t1 
	on t1.issue=t2.issue 
order by t2.total_issue desc
 

-- What are the top 15 products and sub_product that customers complained the most?

select top 15 Product_Name, count(product_name) as count_product_issue
from ConsumerComplaints
group by Product_Name
order by count_product_issue desc

select Product_Name,sub_product, count(sub_product) as totaL_sub_product 
from ConsumerComplaints
group by Product_Name, Sub_Product
order by total_Sub_Product desc 

-- order the number of total complaint from highest to lowest on monthly basis  
select  DATEPART(month,date_received) as month_complaint,
		count(DATEPART(month,date_received)) as total_complaint_PerMonth
from ConsumerComplaints
group by DATEPART(month,date_received)
order by total_complaint_PerMonth desc


--II. Company had high consumer complaints and their response 
--1. What are the top 15 financial company had the high consumer complaints and  disputed order by number of complaints ? 

with table1 as
	(select company,count(consumer_disputed) as disputed
	from ConsumerComplaints 
	where Consumer_Disputed = 'yes'
	group by company
	)

Select top 15 c.company,count(complaint_ID) as complaints_company,t1.disputed
		from ConsumerComplaints c
		join table1 t1
		on c.Company = t1.Company
group by c.Company,t1.disputed
order by complaints_company desc 

-- where are the top 15 locations that consumers complained the most? 

select state_name, count(complaint_id) as total_complaint_perstate
from ConsumerComplaints
group by State_Name
order by total_complaint_perstate desc

-- Timely Reponsive rate of the top 15 company received complaints

with table1 as (
	select company,count(complaint_id) as total_complaint
	from ConsumerComplaints
	group by Company),

table2 as (select company,count(timely_response) as timely_response 
from ConsumerComplaints
where Timely_Response = 'yes'
group by company
)

select t2.company,t2.timely_response,t1.total_complaint,
concat(round(try_convert(float,t2.timely_response)
/try_convert(float,t1.total_complaint),4) * 100,'%') as Ptg_timely_reponse
from table1 t1
join table2 t2 on t1.company = t2.company
order by t1.total_complaint desc


