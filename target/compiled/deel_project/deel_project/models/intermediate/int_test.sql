


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