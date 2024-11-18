-- depends_on: {{ ref('stg_globepay_acceptance_report') }}
-- depends_on: {{ ref('countries') }}
-- depends_on: {{ ref('stg_globepay_chargeback_report') }}

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
        {{ parse_json_simple('rates_json', 'rate_', ['USD', 'EUR', 'CAD', 'GBP', 'MXN', 'SGD', 'AUD']) }}
    FROM base_data
),
enriched_data AS (
    SELECT
        parsed_rates.*,
        countries.name AS country_name
    FROM parsed_rates
    LEFT JOIN {{ ref('countries') }} AS countries
    ON parsed_rates.country = countries.abbreviation
),
final_data AS (
    SELECT
        a.external_ref,
        a.status,
        a.source,
        a.ref,
        a.date_time AS timestamp,
        a.date_time::date AS date,
        a.state,
        a.cvv_provided,
        a.amount,
        a.country,
        a.country_name,
        a.currency,
        a.rate_usd,
        a.rate_eur,
        a.rate_cad,
        a.rate_gbp,
        a.rate_mxn,
        a.rate_sgd,
        a.rate_aud,
        c.chargeback
    FROM enriched_data AS a
    LEFT JOIN {{ ref('stg_globepay_chargeback_report') }} AS c
    ON a.external_ref = c.external_ref
)
SELECT *
FROM final_data
