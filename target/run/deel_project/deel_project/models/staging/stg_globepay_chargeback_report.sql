-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DEEL_PROJECT_DB.RAW_staging.stg_globepay_chargeback_report as DBT_INTERNAL_DEST
        using DEEL_PROJECT_DB.RAW_staging.stg_globepay_chargeback_report__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.external_ref = DBT_INTERNAL_DEST.external_ref
            )

    
    when matched then update set
        "EXTERNAL_REF" = DBT_INTERNAL_SOURCE."EXTERNAL_REF","STATUS" = DBT_INTERNAL_SOURCE."STATUS","SOURCE" = DBT_INTERNAL_SOURCE."SOURCE","CHARGEBACK" = DBT_INTERNAL_SOURCE."CHARGEBACK"
    

    when not matched then insert
        ("EXTERNAL_REF", "STATUS", "SOURCE", "CHARGEBACK")
    values
        ("EXTERNAL_REF", "STATUS", "SOURCE", "CHARGEBACK")

;
    commit;