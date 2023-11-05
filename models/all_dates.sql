-- Use the date_spine macro to build a data spine model in your project called all_dates. This model should list every day in the year 2020.
-- Use a config block to materialize all_dates as a table. (The default materialization will be a view)
{{ config(materialized="table") }}
{{ dbt_utils.date_spine(datepart="day", start_date="cast('2020-01-01' as date)", end_date="cast('2021-01-01' as date)") }}
