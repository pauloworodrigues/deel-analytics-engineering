
  
    

        create or replace transient table DEEL_PROJECT_DB.RAW_intermediate.int_acceptance_report_with_chargebacks
         as
        (-- depends_on: DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report
-- depends_on: DEEL_PROJECT_DB.RAW_seeds.countries
-- depends_on: DEEL_PROJECT_DB.RAW_staging.stg_globepay_chargeback_report



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
    FROM DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report
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
        rates_json:USD::FLOAT AS rate_usd,
  rates_json:EUR::FLOAT AS rate_eur,
  rates_json:CAD::FLOAT AS rate_cad,
  rates_json:GBP::FLOAT AS rate_gbp,
  rates_json:MXN::FLOAT AS rate_mxn,
  rates_json:SGD::FLOAT AS rate_sgd,
  rates_json:AUD::FLOAT AS rate_aud
    FROM base_data
),
enriched_data AS (
    SELECT
        parsed_rates.*,
        countries.name AS country_name
    FROM parsed_rates
    LEFT JOIN DEEL_PROJECT_DB.RAW_seeds.countries AS countries
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
    LEFT JOIN DEEL_PROJECT_DB.RAW_staging.stg_globepay_chargeback_report AS c
    ON a.external_ref = c.external_ref
)
SELECT *
FROM final_data
        );
      
  