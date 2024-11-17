{{ config(materialized="incremental", unique_key="external_ref") }}

SELECT 
    external_ref,
    status,
    source,
    chargeback
FROM {{ source('raw', 'raw_globepay_chargeback_report') }}

{% if is_incremental() %}
WHERE external_ref NOT IN (SELECT external_ref FROM {{ this }})
{% endif %}