-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report as DBT_INTERNAL_DEST
        using DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.external_ref = DBT_INTERNAL_DEST.external_ref
            )

    
    when matched then update set
        "EXTERNAL_REF" = DBT_INTERNAL_SOURCE."EXTERNAL_REF","STATUS" = DBT_INTERNAL_SOURCE."STATUS","SOURCE" = DBT_INTERNAL_SOURCE."SOURCE","REF" = DBT_INTERNAL_SOURCE."REF","DATE_TIME" = DBT_INTERNAL_SOURCE."DATE_TIME","STATE" = DBT_INTERNAL_SOURCE."STATE","CVV_PROVIDED" = DBT_INTERNAL_SOURCE."CVV_PROVIDED","AMOUNT" = DBT_INTERNAL_SOURCE."AMOUNT","COUNTRY" = DBT_INTERNAL_SOURCE."COUNTRY","CURRENCY" = DBT_INTERNAL_SOURCE."CURRENCY","RATES" = DBT_INTERNAL_SOURCE."RATES"
    

    when not matched then insert
        ("EXTERNAL_REF", "STATUS", "SOURCE", "REF", "DATE_TIME", "STATE", "CVV_PROVIDED", "AMOUNT", "COUNTRY", "CURRENCY", "RATES")
    values
        ("EXTERNAL_REF", "STATUS", "SOURCE", "REF", "DATE_TIME", "STATE", "CVV_PROVIDED", "AMOUNT", "COUNTRY", "CURRENCY", "RATES")

;
    commit;