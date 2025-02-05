# Suicide Statistics Analysis and Prediction

## Project Overview

This project aims to analyze and provide insights into suicide statistics in India, leveraging the power of SQL for data transformation, analysis and performance optimization. The project includes a structured approach to data loading, data cleaning, exploratory data analysis (EDA), creating and managing stored procedures and triggers as well as optimizing query performance through indexing and partitioning.

## Project Structure

1. **Data Loading (`suicide_analysis.ctl`)**  
   This section involves the process of loading the `suicide_data.csv` into the database using SQL*Loader. The data is cleaned with transformations applied to handle missing values and standardize the gender and age group columns.

2. **Database Setup (`create_tables.sql`)**  
   This file contains SQL scripts for creating the database schema, the `SUICIDE_STATISTICS` table, and granting the necessary privileges to the `suicide_user`.

3. **Data Transformation & Cleaning (`transformations.sql`)**  
   In this step, we clean the data by removing duplicates, handling null values, and standardizing the gender and age group fields.

4. **Exploratory Data Analysis (`eda_analysis.sql`)**  
   This script performs various EDA tasks including calculating basic statistics, aggregating data by year, state, gender and age group as well as identifying trends.

5. **Stored Procedures (`stored_procedures.sql`)**  
   This file defines two stored procedures:
   - `GET_YEARLY_SUMMARY`: Summarizes suicide data for a given year.
   - `COMPARE_YEARS`: Compares suicide statistics between two years.

6. **Triggers (`triggers.sql`)**  
   This file includes triggers for preventing future year entries and logging updates to suicide statistics.

7. **Performance Optimization (`indexing.sql` & `range_partitioning.sql`)**  
   - **Indexing**: Creates an index on the `YEAR` and `STATE` columns to optimize query performance.
   - **Range Partitioning**: Partitions the `SUICIDE_STATISTICS` table by year to improve query performance, especially when filtering by year.

8. **Query Caching**:  
   Caches query results for frequently accessed data to reduce disk reads and improve performance.
