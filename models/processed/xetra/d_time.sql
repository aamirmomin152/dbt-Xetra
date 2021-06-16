{{ config(
    alias='DIM_TIME',
    unique_key='ID',
    materialized='incremental'
) }}


WITH TIME_DIM AS (
    SELECT 
      ID
    , TRADING_PERIOD_DATE
    , TRADING_PERIOD_TIME
    , TIMESTAMP_FROM_PARTS(TRADING_PERIOD_DATE, TRADING_PERIOD_TIME) AS TRADING_PERIOD_DATETIME
    FROM {{ ref('stage__xetra__stocks') }}
)

SELECT * 
FROM TIME_DIM

