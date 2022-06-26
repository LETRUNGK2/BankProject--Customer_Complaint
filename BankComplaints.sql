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
select issue,count(issue) as total_issue from ConsumerComplaints group by issue)

select top 15 t1.issue,t1.disputed, t2.total_issue,t1.disputed/t2.total_issue as Percentage_dispute
from temp2 t2
inner join
temp1 t1 on t1.issue=t2.issue 
order by t2.total_issue desc
 
-- What are the top 15 products that customers complained the most?

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
-- What are the top 15 financial company had the high complaints? 
-- In those 15 companies, what financial products need to be fixed systemmatically? 
-- where are the top 15 locations that consumers complained the most? 
-- Companies had high responsive rate
-- Companies have low responsive rate