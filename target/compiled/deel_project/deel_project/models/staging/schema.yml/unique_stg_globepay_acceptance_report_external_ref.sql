
    
    

select
    external_ref as unique_field,
    count(*) as n_records

from DEEL_PROJECT_DB.RAW_staging.stg_globepay_acceptance_report
where external_ref is not null
group by external_ref
having count(*) > 1


