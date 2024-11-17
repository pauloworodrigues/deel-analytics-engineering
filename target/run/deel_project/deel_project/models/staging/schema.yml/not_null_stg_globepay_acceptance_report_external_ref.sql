select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select external_ref
from DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report
where external_ref is null



      
    ) dbt_internal_test