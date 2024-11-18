-- depends_on: {{ ref('stg_globepay_acceptance_report') }}

{{ config(materialized="table") }}

WITH base_data AS (
    SELECT
        EXTERNAL_REF,
        STATUS,
        SOURCE,
        REF,
        DATE_TIME,
        STATE,
        CVV_PROVIDED,
        AMOUNT,
        COUNTRY,
        CURRENCY,
        PARSE_JSON(RATES) AS rates_json
    FROM {{ ref('stg_globepay_acceptance_report') }}
),
parsed_rates AS (
    SELECT
        *,
        {{ parse_json_simple('rates_json', 'rate_', ['USD', 'EUR', 'CAD', 'GBP', 'MXN','SGD', 'AUD']) }}
    FROM base_data
)
SELECT *
FROM parsed_rates
