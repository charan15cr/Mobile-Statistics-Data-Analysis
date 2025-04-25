# Mobile Statistics, Data Analysis


**Tools Used**

1. Python

2. SQL

3. Power bi

**Problem Statement**

With the exponential growth in smartphone usage, it has become crucial for manufacturers, retailers, and analysts to understand the evolving dynamics of mobile device offerings. This project aims to examine mobile phone data across various dimensions — including pricing, battery life, RAM, camera specifications, and processor types — and visualize trends across multiple brands and geographies. The objective is to uncover key patterns in device launches, assess regional price variations, and highlight specifications that dominate the market, thereby enabling strategic decision-making in product positioning and market targeting.

---
Mobile data & Statistics Dashboard
---
![Image](https://github.com/user-attachments/assets/e5be018b-daa2-4901-bca3-b786a81d51d3)
---

**Steps Involved**

1. **Imports**
   - Imported `pandas`, `numpy`, and `matplotlib.pyplot`.

2. **Data Loading**
   - Loaded the dataset from a `.csv` file using `pd.read_csv()`.

3. **Initial Data Exploration**
   - `df.head()` to preview data.
   - `df.shape`, `df.columns`, `df.dtypes`, and `df.describe()` to understand data structure.
   ![Image](https://github.com/user-attachments/assets/45b00ad5-f661-47c3-a32d-9851c6c39d7a)

4. **Missing Data Handling**
   - `df.isnull().sum()` to identify nulls.
   - Dropped rows or columns based on missing thresholds.
   - Filled some missing values conditionally (e.g., mode or median).

5. **Data Cleaning**
   
    Cleaned columns like:

      **Price**: removed currency signs (₹, $, etc.), commas, and converted to float.
     ```http
     df['launch_price(INDIA)'] = (
    df['launch_price(INDIA)']
    .str.replace('INR', '', regex=False)
    .str.replace(',', '', regex=False)
    .astype(int)
    )

    df['launch_price(CHINA)'] = (
    df['launch_price(CHINA)']
    .str.replace('CNY', '', regex=False)
    .str.replace(',', '', regex=False)
    .str.replace('¥', '', regex=False) # Adding this line to remove the '¥' symbol
    .astype(int)
    )

    df['launch_price(USA)'] = (
    df['launch_price(USA)']
    .str.replace('USD', '', regex=False)
    .str.replace(',', '', regex=False)
    .astype(float)
    )

    df['launch_price(DUBAI)'] = (
    df['launch_price(DUBAI)']
    .str.replace('AED', '', regex=False)
    .str.replace(',', '', regex=False)
    .astype(int)
    )

     ```
      **Battery**: stripped “mAh” text and converted to integer.
     ```http
     df['battery_capacity(mAh)'] = (
    df['battery_capacity(mAh)']
    .str.replace('mAh', '', regex=False)
    .str.replace(',', '', regex=False)
    .astype(int)
    )
     ```
      **Weight**: replace g and made the values to  
     flot numbers.
   ```http
   df['mobile_weight(g)'] = df['mobile_weight(g)'].str.replace('g', '', regex=False).astype(float)
   ```
    **Renaming** : renaming the columns name
   ```http
   df.rename(columns={
    'Company Name': 'company_name',
    'Model Name': 'modle_name',
    'Mobile Weight': 'mobile_weight(g)',
    'RAM': 'RAM(GB)',
    'Front Camera': 'front_camera(Mp)',
    'Back Camera': 'back_camera(Mp)',
    'Battery Capacity': 'battery_capacity(mAh)',
    'Screen Size': 'screen_size(inch)',
    'Launched Price (India)': 'launch_price(INDIA)',
    'Launched Price (China)': 'launch_price(CHINA)',
    'Launched Price (USA)': 'launch_price(USA)',
    'Launched Price (Dubai)': 'launch_price(DUBAI)',
    'Launched Year': 'launch_year'
    }, inplace=True)
   ```
   ![Image](https://github.com/user-attachments/assets/ccdee2d5-9197-4009-ad69-963be0e8d23e)
6. **Null Values**
   : Checked for null values entries.

7. **Latin Code** : Changed the latin code error
```http
df = pd.read_csv('mobiles_dataset_2025.csv', encoding='latin-1')
df.head()
```
---

**SQL Queries**
--
The `mobile_sql.sql` script is designed to clean, structure, and prepare mobile device data for analysis and visualization. It begins by creating a table with fields like brand, model, pricing, specifications (RAM, battery, camera, processor), and launch year. The script performs extensive data cleaning, including removing currency symbols from prices, stripping text units from battery and RAM fields, and converting all key fields to numeric types. It also parses complex fields such as camera specs using string functions and handles missing values using conditional logic. Additionally, it engineers new features like price, RAM, and battery categories to enable easier grouping. Finally, the script includes several aggregation queries to compute metrics such as average prices, battery capacity, and device counts by brand or year—providing a clean, analysis-ready dataset for Power BI dashboards or other reporting tools.

**snap shots**

1. Columns and rows of the data
```http
select * from mobiles
```
![Image](https://github.com/user-attachments/assets/695d11b0-8d87-4d2c-b806-61c62b2d3565)

2. Total Moblie Devices
```http
select count(company_name) as total_mobiles
from mobiles

```
![Image](https://github.com/user-attachments/assets/809ee67e-f5b4-4641-93ef-27d4add5d427)

3. Total Compay
```http
select company_name as mobile_companies
from mobiles
group by company_name
order by company_name
```
![Image](https://github.com/user-attachments/assets/8c6c0f24-6547-4f3a-b919-89b6c4167c73)

4. Highest pricing device from each company in India(INR) 
```http
select company_name,
max(launch_price_india) as highest_price_in_INDIA_INR
from mobiles
group by company_name
order by highest_price_in_INDIA_INR desc
```
![Image](https://github.com/user-attachments/assets/9a9f3bb3-1c55-445a-8f29-2263699f1978)

5. Average pricing devices from each company in Indai 
```http
select company_name,
cast(avg(launch_price_india) as decimal(10,2)) as avg_price_in_INDIA_INR
from mobiles
group by company_name
order by avg_price_in_INDIA_INR desc
```
![Image](https://github.com/user-attachments/assets/9c607a83-4a5f-42e4-a819-6901665cca7c)

6. Highest pricing device from each company in USA(USD)
```http
select company_name,
max(launch_price_usa) as highest_price_in_USA_USD
from mobiles
group by company_name
order by highest_price_in_USA_USD desc
```
![Image](https://github.com/user-attachments/assets/9bda978e-5a71-4d1b-bccb-396c969cbe91)

7. Price Difference between INDIA and USA
```http
SELECT
  company_name,
  modle_name,
  launch_price_india,
  launch_price_usa,
  ROUND(launch_price_india - (launch_price_usa * 83)) AS india_vs_usa_diff_in_inr
FROM mobiles
ORDER BY india_vs_usa_diff_in_inr desc
limit 5
```
![Image](https://github.com/user-attachments/assets/92034186-2c2a-4ddd-bed6-631e859d38f4)

8. RAM categories and divices
```http
SELECT RAM_GB, COUNT(*) AS no_of_mobiles
FROM mobiles
GROUP BY RAM_GB
ORDER BY no_of_mobiles DESC
limit 6

```
![Image](https://github.com/user-attachments/assets/e771649e-d168-4959-bbfa-05337c235751)

9. Number of devices launched each Year
```http
SELECT launch_year, COUNT(*) AS launches
FROM mobiles
GROUP BY launch_year
ORDER BY launch_year desc
```
![Image](https://github.com/user-attachments/assets/6745c3fd-4b37-4331-abca-0c812f685737)

10. Devices with Average batetry capacity along with Average price by each company launched in India
```http
SELECT
  launch_year,
  company_name,
  COUNT(*) AS models_launched,
  ROUND(AVG(battery_capacity_mAh)) AS avg_battery,
  ROUND(AVG(launch_price_india)) AS avg_price_inr
FROM mobiles
GROUP BY launch_year, company_name
ORDER BY launch_year desc
```
![Image](https://github.com/user-attachments/assets/f89d841f-3dc8-46ef-8b65-5108d6638272)

---
Power bi snap shots
--
Includes operations such as creating **new measure, grouping certain data** to get more precise outcome

1. **Cards**

![Image](https://github.com/user-attachments/assets/9aace6e7-b4ae-4727-a1a8-eb667f2687e9)

2. **Bar chart**

![Image](https://github.com/user-attachments/assets/96a7623a-c720-4746-a06a-dbff91d4ad9b)

3. **Line Chart** :
This line chart compares the average mobile selling prices in India, USA, and China across brands.  
**Apple** leads with the highest prices, followed by **Huawei**, **Sony**, and **Google**.  
Prices gradually drop towards brands like **Infinix** and **Nokia**, which are the cheapest.

![Image](https://github.com/user-attachments/assets/934ad8ae-b942-40f4-aba1-6d6cfa482068)

4. **Pie chart** :
This pie chart shows the distribution of processor categories in mobile devices.  
**Qualcomm Snapdragon** dominates with 40.11%, followed by **MediaTek Dimensity** at 31.08%.  
Other processors like Exynos, A-series, and Google Tensor have smaller shares.

![Image](https://github.com/user-attachments/assets/14c9b799-1863-4d55-a558-ee1845571a80)

5. **Line chart** :
This line chart shows the number of mobile devices launched each year.  
There’s a sharp rise after 2018, peaking around 2022 and so on with nearly 300 devices launched.  
A steep drop is seen immediately after, likely due to incomplete data for recent years.

![Image](https://github.com/user-attachments/assets/66c8b542-289a-40a2-ab2b-361e274ca1da)

6. **Scatter Plot** :
This scatter plot shows the relationship between battery capacity and mobile pricing in India.  
Most devices fall under ₹100,000 regardless of battery size, with dense clusters around 5,000–7,000 mAh.  
There’s no strong correlation—higher battery doesn’t always mean higher price.

![Image](https://github.com/user-attachments/assets/c25200ca-704b-467f-9ef4-ddd40fb29229)

7. **Tree Map** :
Shows each category of **RAM** Available

![Image](https://github.com/user-attachments/assets/9e9d5168-d3b5-4024-96c8-e5b123399940)

8. **Donut Chart** : 
This donut chart shows the distribution of mobile devices by back camera categories.  
Over half (53.44%) of the devices have **50MP & 50MP** back cameras.  
Other popular setups include **40MP & 48MP** and **13MP & 13MP** combinations.

![Image](https://github.com/user-attachments/assets/dac722a0-944c-4341-9e7c-b609c05740de)

---
Outcome
--
The mobile phone market has been growing rapidly, with a peak in device launches around 2022 and so on, as shown in the year-wise trend. Qualcomm Snapdragon dominates the processor market (40%), while MediaTek Dimensity holds a strong second position (31%). Devices with 50MP+ back cameras are most common, reflecting a consumer preference for high-resolution photography. Pricing analysis shows Apple, Huawei, and Sony leading the premium segment, while Infinix offer budget options. Battery capacity varies widely, but there's no strong link between battery size and price in India. **Overall, the mobile market trends toward high-performance specifications and mid-range affordability across global regions**.

---
**Linedin Profile** : www.linkedin.com/in/charan-r-b04875358
