

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

