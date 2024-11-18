
  
    

        create or replace transient table DEEL_PROJECT_DB.RAW_staging.stg_globeplay_chargeback_report
         as
        (

SELECT 
    external_ref,
    status,
    source,
    chargeback
FROM DEEL_PROJECT_DB.raw.raw_globepay_chargeback_report


        );
      
  