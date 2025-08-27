### 0. Google queries

Go into marketplace under data products in snowsight. Search and get the following dataset `Google Keywords search dataset - discover all searches on Google`.

Now create a worksheet on your local repository and start querying this data through snowsql.

&nbsp; a) Use this database and find out the underlying schemas, tables and views to get an overview of its logical structure.

&nbsp; b) Find out the columns and its data types in the table `GOOGLE_KEYWORDS`.

We will now do some exploratory data analysis (EDA) of this dataset.

&nbsp; c) Find out number of rows in the dataset.

&nbsp; d) When is the first search and when is the latest search in the dataset?

&nbsp; e) Which are the 10 most popular keywords?

&nbsp; f) How many unique keywords are there?

&nbsp; g) Check what type of platforms are used and how many users per platform

&nbsp; h) Let's dive into what swedish people are searching. Go into [worldbanks country codes](https://wits.worldbank.org/wits/wits/witshelp/content/codes/country_codes.htm) to find out the country code for Sweden. Find the 20 most popular keywords and the number of searches of that keyword.

&nbsp; i) Lets see how popular spotify is around the world. List the top 10 number countries and the number of searches for spotify. 

&nbsp; j) Feel free to do additional explorations of this dataset.



- Snowflake edition: Enterprise
- Cloud provider Azure
- Region West Europe (Netherlands)
- Compute price/credit: $3.90

&nbsp; a) You have a simple workload that runs daily in Snowflake. The workload uses 0.5 credits per day. Calculate the total credit usage and cost for a 30-day month.

&nbsp;Calculate Monthly Credit Usage

Given:

Daily usage: 0.5 credits
Days in month: 30
Price per credit: $3.90
Calculation:

Total credits used: 0.5 × 30 = 15 credits
Total cost: 15 × $3.90 = $58.50

Answer:
For a 30-day month, your workload will use 15 credits and cost $58.50.

&nbsp; b) Your workload varies throughout the month. For the first 10 days, you use 2 credits per day. For the next 10 days, you use 1.5 credits per day, and for the last 10 days, you use 1 credit per day. Calculate the total credit usage and cost for a 30-day month.

Credit usage:

First 10 days: 2 credits/day × 10 days = 20 credits
Next 10 days: 1.5 credits/day × 10 days = 15 credits
Last 10 days: 1 credit/day × 10 days = 10 credits

Total credits used:
20 + 15 + 10 = 45 credits

Total cost:
45 credits × $3.90/credit = $175.50

Answer:
For a 30-day month, your workload will use 45 credits and cost $175.50.

&nbsp; c) You have three different warehouses running workloads simultaneously. Warehouse A is of size XS, Warehouse B is of size S, and Warehouse C is of size M. Warehouse A is used for 10h/day, B is used for 2h/day and C is used for 1h/day. Calculate the total monthly cost assuming each warehouse runs for the full 30-day month.

Assume standard Snowflake credit consumption per hour:

XS: 0.5 credits/hour
S: 1 credit/hour
M: 2 credits/hour

Usage per warehouse:

Warehouse A (XS): 10h/day × 30 days × 0.5 credits/h = 150 credits
Warehouse B (S): 2h/day × 30 days × 1 credit/h = 60 credits
Warehouse C (M): 1h/day × 30 days × 2 credits/h = 60 credits

Total credits used:
150 + 60 + 60 = 270 credits

Total cost:
270 credits × $3.90/credit = $1,053.00

Answer:
For a 30-day month, your three warehouses will use 270 credits and cost $1,053.00.

&nbsp; d) Your Snowflake warehouse uses auto-scaling. For the first 10 days, it operates on 2 clusters for 10 hours per day. For the next 10 days, it scales up to 3 clusters for 10 hours per day. For the last 10 days, it scales up to 4 clusters for 10 hours per day. Calculate the total monthly budget. Assume the warehouse consumes 1 credit per hour per cluster.

Credit usage:

First 10 days: 2 clusters × 10 hours/day × 10 days × 1 credit/hour = 200 credits
Next 10 days: 3 clusters × 10 hours/day × 10 days × 1 credit/hour = 300 credits
Last 10 days: 4 clusters × 10 hours/day × 10 days × 1 credit/hour = 400 credits

Total credits used:
200 + 300 + 400 = 900 credits

Total cost:
900 credits × $3.90/credit = $3,510.00

Answer:
For a 30-day month, your auto-scaling warehouse will use 900 credits and cost $3,510.00.
