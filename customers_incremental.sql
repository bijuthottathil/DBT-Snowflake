{{ config(
    materialized='table',
    unique_key='CUSTOMER_ID',
    merge_update_columns = ['CUSTOMER_NAME', 'EMAIL', 'UPDATED_AT']
) }}

{% if is_incremental() %}

    WITH changes AS (
        SELECT *
        FROM {{ ref('stg_customers') }}
        WHERE UPDATED_AT > (SELECT COALESCE(MAX(UPDATED_AT), '1970-01-01T00:00:00Z') FROM {{ this }})
    )

    MERGE INTO {{ this }} AS target
    USING changes AS source
    ON target.CUSTOMER_ID = source.CUSTOMER_ID
    WHEN MATCHED THEN
        UPDATE SET
            {% for column in config.get('merge_update_columns') %}
                {{ column }} = source.{{ column }}{% if not loop.last %}, {% endif %}
            {% endfor %}
    WHEN NOT MATCHED THEN
        INSERT (CUSTOMER_ID, CUSTOMER_NAME, EMAIL, UPDATED_AT)
        VALUES (source.CUSTOMER_ID, source.CUSTOMER_NAME, source.EMAIL, source.UPDATED_AT)

{% else %}

    SELECT *
    FROM {{ ref('stg_customers') }}

{% endif %}