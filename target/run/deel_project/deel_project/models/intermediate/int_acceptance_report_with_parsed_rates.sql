
  
    

        create or replace transient table DEEL_PROJECT_DB.RAW_intermediate.int_acceptance_report_with_parsed_rates
         as
        (-- depends_on: DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report



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
        *,
        rates_json:USD::FLOAT AS rate_usd,
  rates_json:EUR::FLOAT AS rate_eur,
  rates_json:CAD::FLOAT AS rate_cad,
  rates_json:GBP::FLOAT AS rate_gbp,
  rates_json:MXN::FLOAT AS rate_mxn,
  rates_json:SGD::FLOAT AS rate_sgd,
  rates_json:AUD::FLOAT AS rate_aud
    FROM base_data
)
SELECT *
FROM parsed_rates
        );
      
  