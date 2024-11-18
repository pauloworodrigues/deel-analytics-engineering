{{ config(materialized="table") }}

SELECT
    a.external_ref,
    a.status,
    a.source,
    a.ref,
    a.timestamp,
    a.date,
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
    a.chargeback,
    CASE
        WHEN a.chargeback IS NULL THEN TRUE
        ELSE FALSE
    END AS is_missing_chargeback
FROM {{ ref('int_acceptance_report_with_chargebacks') }} AS a
