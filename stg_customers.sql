{{ config(materialized='table') }}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    UPDATED_AT
FROM {{ source('employee_source', 'CUSTOMER') }}