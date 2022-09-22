# import data
import pandas as pd
df = pd.read_csv("sample-store.csv")

# preview top 5 rows
df.head()

# shape of dataframe
df.shape

# see data frame information using .info()
df.info()

# TODO - convert order date and ship date to datetime in the original dataframe
df['Order Date'] = pd.to_datetime(df['Order Date'], format = '%m/%d/%Y')
df['Ship Date'] = pd.to_datetime(df['Ship Date'], format = '%m/%d/%Y')
df.info()

# TODO - count nan in postal code column
df['Postal Code'].isna().sum()

# TODO - filter rows with missing values
df[df['Postal Code'].isna()]

#TODO - What Sub-Category of product are ordered the most?
df.groupby('Sub-Category')['Quantity'].sum().sort_values(ascending = False).head(1)

# Data analysis part

# TODO 01 - how many columns, rows in this dataset
df.shape

# TODO 02 - is there any missing values?, if there is, which colunm? how many nan values?
df.isna().sum()

# TODO 03 - your friend ask for `California` data, filter it and export csv for him
df_California =df.query('State == "California"')
df_California.to_csv("California data.csv")

# TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file
df_CA_TA = df.query('State == "California" or State == "Texas"')
df_CA_TA_2017 = df_CA_TA[df_CA_TA["Order Date"].dt.year == 2017]
df_CA_TA_2017.to_csv("order data in California and Texas in 2017")

# TODO 05 - how much total sales, average sales, and standard deviation of sales your company make in 2017
df_2017 = df[df["Order Date"].dt.year == 2017]
df_2017['Sales']
df_sales_2017 = df_2017['Sales'].agg(['mean','sum','std'])
df_sales_2017

# TODO 06 - which Segment has the highest profit in 2018
df_2018 = df[df["Order Date"].dt.year == 2018]
df_2018.groupby('Segment')['Profit'].sum().reset_index()

# TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019
df_15April_to_31Dec = df[(df["Order Date"] >= '15/4/2019') & (df["Order Date"] <= '31/12/2019')]
df_15April_to_31Dec.groupby('State')['Sales'].sum().sort_values().head(5).reset_index()

# TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25% 
df_2019 = df[df["Order Date"].dt.year == 2019]
df_2019_Ts = df_2019['Sales'].sum()
df_2019_West_Central_Ts = df_2019.query('Region == "West" | Region == "Central"')['Sales'].sum()
Proportion = (df_2019_West_Central_Ts/df_2019_Ts)*100
print(f"The proportion of total sales (%) in West + Central in 2019 : {Proportion}%")

# TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020
df_2019_and_2020 = df[(df["Order Date"].dt.year == 2019) |  (df["Order Date"].dt.year == 2020)]
df_2019_and_2020
Top10_products_num_orders = df_2019_and_2020.groupby('Product Name')['Quantity'].sum().sort_values(ascending = False).head(10)
Top10_products_num_orders
Top10_products_sales =  df_2019_and_2020.groupby('Product Name')['Sales'].sum().sort_values(ascending = False).head(10)
Top10_products_sales

# TODO 10 - plot at least 2 plots, any plot you think interesting :)
df['Region'].value_counts().plot(kind = 'bar',color = ['yellow','green','blue','red'])
df_2019_and_2020 = df[(df["Order Date"].dt.year == 2019) |  (df["Order Date"].dt.year == 2020)]
df_2019_and_2020[['Order Date','Quantity']].plot(x = 'Order Date',y = 'Quantity', kind="line" ,color= "Blue" )

# TODO Bonus - use np.where() to create new column in dataframe to help you answer your own questions
import numpy as np
df_Profit_or_loss = np.where(df['Profit']>0, 'Profit','Loss') 
df_Profit_or_loss





