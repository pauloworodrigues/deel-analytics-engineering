

SELECT 
    external_ref,
    status,
    source,
    chargeback
FROM DEEL_PROJECT_DB.raw.raw_globepay_chargeback_report


WHERE external_ref NOT IN (SELECT external_ref FROM DEEL_PROJECT_DB.RAW_staging.stg_globeplay_chargeback_report)
