
  
    

        create or replace transient table DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report
         as
        (

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


        );
      
  