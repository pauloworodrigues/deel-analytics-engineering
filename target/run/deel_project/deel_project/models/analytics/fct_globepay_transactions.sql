
  
    

        create or replace transient table DEEL_PROJECT_DB.RAW_analytics.fct_globepay_transactions
         as
        (

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
FROM DEEL_PROJECT_DB.RAW_intermediate.int_acceptance_report_with_chargebacks AS a
        );
      
  