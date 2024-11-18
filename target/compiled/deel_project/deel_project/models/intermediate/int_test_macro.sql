-- depends_on: DEEL_PROJECT_DB.RAW_intermediate.int_test



WITH base_data AS (
    SELECT *
    FROM DEEL_PROJECT_DB.RAW_intermediate.int_test
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