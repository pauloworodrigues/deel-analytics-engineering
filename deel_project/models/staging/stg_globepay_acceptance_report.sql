{{ config(
    materialized="incremental",
    unique_key="external_ref"
) }}

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
FROM {{ source('raw', 'raw_globepay_acceptance_report') }}

{% if is_incremental() %}
    WHERE external_ref NOT IN (SELECT external_ref FROM {{ this }})
{% endif %}
