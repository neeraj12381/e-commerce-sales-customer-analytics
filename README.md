# E-Commerce Sales & Customer Analytics

## Project Overview

This project focuses on analyzing e-commerce sales and customer data to understand business performance, customer behavior, product performance, and profitability.

The project uses Python for data cleaning and exploratory data analysis, MySQL for business analysis, and Power BI for interactive dashboard development. The objective is to transform raw data into meaningful insights that support data-driven business decisions.

## Business Problem

E-commerce businesses generate large amounts of data, but analyzing this data effectively is essential for understanding sales performance, customer behavior, and profitability.

This project analyzes e-commerce data to identify business trends, evaluate product performance, understand customer purchasing patterns, and explore factors affecting profitability.

## Objectives

- Analyze overall sales, profit, and profit margin.
- Identify monthly sales trends and business performance patterns.
- Evaluate product and category performance.
- Analyze customer purchasing behavior and repeat customers.
- Understand payment mode and shipping mode preferences.
- Evaluate the relationship between discounts and profitability.
- Compare sales performance across different states and cities.
- Develop an interactive Power BI dashboard to support data-driven decisions.

## Dataset Description

The project uses an e-commerce dataset containing order transactions, customer information, and product details.

The dataset consists of three main tables:

| Dataset   | Description                                                                                      |
| --------- | ------------------------------------------------------------------------------------------------ |
| Orders    | Order dates, customer IDs, product IDs, quantity, sales, profit, payment mode, and shipping mode |
| Customers | Customer names, gender, age, city, and state                                                     |
| Products  | Product names, categories, sub-categories, and cost prices                                       |

The raw dataset contains data quality issues, including duplicate records, missing values, inconsistent text formatting, and invalid product references. These issues were addressed during the data cleaning and preparation process.

## Tools & Technologies

| Tool / Technology | Purpose                                       |
| ----------------- | --------------------------------------------- |
| Microsoft Excel   | Source dataset                                |
| Python            | Data cleaning and exploratory data analysis   |
| Pandas            | Data manipulation and data analysis           |
| NumPy             | Numerical operations                          |
| Matplotlib        | Data visualization during EDA                 |
| MySQL             | SQL-based business analysis                   |
| Power BI          | Interactive dashboards and business reporting |

## Data Cleaning & Preparation

Data cleaning was performed using Python and Pandas to improve data quality and prepare the dataset for analysis.

Key cleaning activities included:

- Removed duplicate records.
- Standardized text values and column names.
- Handled missing values in the dataset.
- Converted date and numerical columns into appropriate data types.
- Merged product cost information with order data.
- Identified invalid product references.
- Created a cleaned dataset for reliable business analysis.

Orders with missing sales values and invalid product references were excluded from the final analysis dataset.

## Exploratory Data Analysis (EDA)

Exploratory Data Analysis was performed using Python, Pandas, NumPy, and Matplotlib to identify trends, patterns, and relationships in the cleaned dataset.

The analysis covered:

- Overall sales and profit performance.
- Monthly sales and profit trends.
- Category and sub-category performance.
- Top-performing products and customers.
- Customer order frequency and repeat purchasing behavior.
- Payment mode and shipping mode analysis.
- Discount impact on sales and profitability.
- State-wise and city-wise sales performance.

The findings from EDA helped identify important business patterns and supported further SQL analysis and dashboard development.

## SQL Analysis

MySQL was used to perform structured business analysis on the cleaned e-commerce dataset.

The SQL analysis included:

- Basic queries for exploring business data.
- JOIN operations to combine orders, customers, and products.
- Business analysis using aggregate functions.
- Subqueries for advanced data filtering and comparisons.
- Common Table Expressions (CTEs) to organize complex queries.
- Window functions for ranking and comparative analysis.
- Advanced SQL queries to identify business trends and performance patterns.

The results helped identify top-performing products, customer purchasing patterns, and key sales and profitability insights.

## Power BI Dashboard

An interactive Power BI dashboard was developed to monitor key business performance indicators and explore sales, profitability, customer behavior, and operational performance.

The dashboard contains three pages:

1. **Executive Sales Dashboard** — Presents key performance indicators (KPIs), monthly sales and profit trends, payment mode analysis, shipping mode analysis, and product and regional performance.
2. **Customer Analysis** — Examines customer distribution, repeat purchasing behavior, average orders per customer, and sales across states and cities.
3. **Business Insights & Recommendations** — Summarizes key findings and provides recommendations to improve profitability, customer retention, and business performance.

The dashboard uses KPI cards, charts, and slicers to support interactive data exploration and business decision-making.

## Key Business Insights

- **Sales Performance:** The business generated approximately ₹47.63 million in total sales.
- **Profitability:** Total profit was approximately ₹4.20 million, with an overall profit margin of around 8.81%.
- **Customer Retention:** 292 out of 300 customers were classified as repeat customers, indicating strong repeat purchasing behavior.
- **Product Performance:** Product-level analysis identified top-performing products and opportunities to review low-profit products.
- **Discount Analysis:** Discount levels should be monitored to understand their impact on sales and profitability.
- **Regional Performance:** State-wise and city-wise analysis helped identify differences in sales performance across regions.
- **Operational Analysis:** Payment and shipping mode analysis provided insights into transaction and delivery preferences.

## Business Recommendations

Based on the analysis, the following recommendations are proposed:

- **Improve Customer Retention:** Maintain engagement with existing customers while developing strategies to attract new customers.
- **Optimize Discounts:** Monitor discount levels to balance sales growth with profitability.
- **Focus on Top Products:** Prioritize high-performing products and review low-profit products for pricing and cost optimization.
- **Strengthen Regional Performance:** Explore growth opportunities in high-performing states and cities.
- **Improve Operational Decisions:** Use payment and shipping mode insights to improve customer experience and operational efficiency.
- **Monitor Business KPIs:** Regularly track sales, profit, and profit margin through the Power BI dashboard.

## Project Workflow

The project followed an end-to-end data analytics lifecycle using an iterative approach.

1. **Requirement Understanding:** Defined the business objectives and key analysis questions.
2. **Data Collection:** Loaded order, customer, and product datasets.
3. **Data Cleaning:** Cleaned and prepared the data using Python and Pandas.
4. **Exploratory Data Analysis:** Identified trends and patterns in the dataset.
5. **SQL Analysis:** Used MySQL to perform structured business analysis.
6. **Dashboard Development:** Built interactive reports using Power BI.
7. **Insights & Recommendations:** Summarized findings and proposed business improvement opportunities.

## Conclusion

This project demonstrates an end-to-end data analytics workflow using Python, MySQL, and Power BI. It covers data cleaning, exploratory data analysis, SQL-based business analysis, and interactive dashboard development.

The project provides insights into sales performance, profitability, customer behavior, product performance, and regional trends. These insights can help businesses make informed, data-driven decisions and identify opportunities for improvement.
