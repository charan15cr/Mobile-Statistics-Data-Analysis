CREATE TABLE mobiles (
    company_name TEXT,
    modle_name TEXT,
    mobile_weight_g FLOAT,
    RAM_GB TEXT,
    front_camera_mp TEXT,
    back_camera_mp TEXT,
    processor TEXT,
    battery_capacity_mAh INTEGER,
    screen_size_inch TEXT,
    launch_price_india INTEGER,
    launch_price_china INTEGER,
    launch_price_usa FLOAT,
    launch_price_dubai INTEGER,
    launch_year INTEGER
);



select * from mobiles

select count(company_name) as total_mobiles
from mobiles


select count(distinct company_name) as total_mobile_company 
from mobiles

select company_name as mobile_companies
from mobiles
group by company_name
order by company_name

select company_name,
 			max(launch_price_india) as highest_price_in_INDIA_INR
from mobiles
group by company_name
order by highest_price_in_INDIA_INR desc

select company_name,
 			cast(avg(launch_price_india) as decimal(10,2)) as avg_price_in_INDIA_INR
from mobiles
group by company_name
order by avg_price_in_INDIA_INR desc

select company_name,
 			min(launch_price_india) as min_price_in_INDIA_INR
from mobiles
group by company_name
order by company_name

select company_name,
 			max(launch_price_china) as highest_price_in_CHINA_CNY
from mobiles
group by company_name
order by highest_price_in_CHINA_CNY desc

select company_name,
 			max(launch_price_usa) as highest_price_in_USA_USD
from mobiles
group by company_name
order by highest_price_in_USA_USD desc

select company_name,
 			max(launch_price_dubai) as highest_price_in_DUBAI_AED
from mobiles
group by company_name
order by highest_price_in_DUBAI_AED desc


SELECT
  company_name,
  modle_name,
  launch_price_india,
  launch_price_usa,
  ROUND(launch_price_india - (launch_price_usa * 83)) AS india_vs_usa_diff_in_inr
FROM mobiles
ORDER BY india_vs_usa_diff_in_inr desc
limit 5

SELECT RAM_GB, COUNT(*) AS no_of_mobiles
FROM mobiles
GROUP BY RAM_GB
ORDER BY no_of_mobiles DESC
limit 6

select company_name,
	max(battery_capacity_mAh) as avg_battery
from mobiles
group by company_name
order by avg_battery

SELECT launch_year, COUNT(*) AS launches
FROM mobiles
GROUP BY launch_year
ORDER BY launch_year desc

SELECT launch_year, 
	cast(avg(launch_price_india)as decimal(10,2)) AS avg_price_in_india_over_the_year
FROM mobiles
GROUP BY launch_year
ORDER BY launch_year desc

SELECT company_name, 
COUNT(*) AS model_count
FROM mobiles
GROUP BY company_name
ORDER BY model_count DESC

SELECT * FROM mobiles
ORDER BY mobile_weight_g DESC
LIMIT 5;

SELECT
  launch_year,
  company_name,
  COUNT(*) AS models_launched,
  ROUND(AVG(battery_capacity_mAh)) AS avg_battery,
  ROUND(AVG(launch_price_india)) AS avg_price_inr
FROM mobiles
GROUP BY launch_year, company_name
ORDER BY launch_year desc

