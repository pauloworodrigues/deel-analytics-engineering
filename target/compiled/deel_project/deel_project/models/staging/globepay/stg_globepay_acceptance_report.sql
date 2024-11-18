

SELECT
    external_ref,
    status,
    source,
    ref,
    date_time,
    state,
    cvv_provided,
    amount,
    country,
    currency,
    rates
FROM DEEL_PROJECT_DB.raw.raw_globepay_acceptance_report


    WHERE external_ref NOT IN (SELECT external_ref FROM DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report)
