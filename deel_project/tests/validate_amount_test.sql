SELECT *
FROM {{ ref('stg_globepay_acceptance_report') }}
WHERE amount <= 0;
