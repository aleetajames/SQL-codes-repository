
select * from (SELECT 
cohort_term_code
, 'Graduation Headcount'  AS data_type
, COUNT (student_cid) AS cohort_size_original
, COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS cohort_size_adj_1
, COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS cohort_size_adj_6
, COUNT (CASE WHEN (exclude_8 = '0') THEN student_cid END) AS cohort_size_adj_8

, COUNT(CASE WHEN grad_term_8 = '1'  THEN student_cid END ) AS "2-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_16 = '1' THEN student_cid END ) AS "4-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_20 = '1' and grad_term_16 = '0' THEN student_cid END ) AS "5-Yr Graduation"
, COUNT(CASE WHEN grad_term_24 = '1'  and grad_term_20 = '0' THEN student_cid END ) AS "6-Yr Graduation"
, COUNT(CASE WHEN grad_term_28 = '1' and grad_term_24 = '0' THEN student_cid END ) AS "7-Yr  Graduation"
, COUNT(CASE WHEN grad_term_29 = '0' THEN student_cid END ) AS "Not Graduated Within 7-Yrs"

FROM unc.uncw.da_gradret
WHERE cohort_term_code LIKE '%6'
AND student_full_part_time = 'F'
AND new_student_type = 'F'
AND grad_retn_from = '1'
and cohort_term_code <> '20246'

GROUP BY cohort_term_code

union all 


SELECT 
cohort_term_code
, 'PELL'  AS data_type
,  COUNT(CASE when pell = '1'  THEN student_cid END ) AS cohort_size_original
, COUNT (CASE WHEN (exclude_1 = '0') and pell = '1' THEN student_cid END) AS cohort_size_adj_1
, COUNT (CASE WHEN (exclude_6 = '0') and pell = '1' THEN student_cid END) AS cohort_size_adj_6
, COUNT (CASE WHEN (exclude_8 = '0') and pell = '1' THEN student_cid END) AS cohort_size_adj_8

, COUNT(CASE WHEN grad_term_8 = '1' and pell = '1'  THEN student_cid END ) AS "2-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_16 = '1' and pell = '1' THEN student_cid END ) AS "4-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_20 = '1' and grad_term_16 = '0' and pell = '1' THEN student_cid END ) AS "5-Yr Graduation"
, COUNT(CASE WHEN grad_term_24 = '1'  and grad_term_20 = '0' and pell ='1' THEN student_cid END ) AS "6-Yr Graduation"
, COUNT(CASE WHEN grad_term_28 = '1' and grad_term_24 = '0' and pell ='1' THEN student_cid END ) AS "7-Yr  Graduation"
, COUNT(CASE WHEN grad_term_29 = '0' THEN student_cid END ) AS "Not Graduated Within 7-Yrs"

FROM unc.uncw.da_gradret
WHERE cohort_term_code LIKE '%6'
AND student_full_part_time = 'F'
AND new_student_type = 'F'
AND grad_retn_from = '1'
and cohort_term_code <> '20246'

GROUP BY cohort_term_code


union all 

SELECT 
cohort_term_code
, 'SSL_NoPELL'  AS data_type
,  COUNT(CASE when ssl_no_pell = '1'  THEN student_cid END ) AS cohort_size_original
, COUNT (CASE WHEN (exclude_1 = '0') and ssl_no_pell = '1' THEN student_cid END) AS cohort_size_adj_1
, COUNT (CASE WHEN (exclude_6 = '0') and ssl_no_pell = '1' THEN student_cid END) AS cohort_size_adj_6
, COUNT (CASE WHEN (exclude_8 = '0') and ssl_no_pell = '1' THEN student_cid END) AS cohort_size_adj_8

, COUNT(CASE WHEN grad_term_8 = '1' and ssl_no_pell = '1'  THEN student_cid END ) AS "2-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_16 = '1' and ssl_no_pell = '1' THEN student_cid END ) AS "4-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_20 = '1' and grad_term_16 = '0' and ssl_no_pell = '1' THEN student_cid END ) AS "5-Yr Graduation"
, COUNT(CASE WHEN grad_term_24 = '1'  and grad_term_20 = '0' and ssl_no_pell ='1' THEN student_cid END ) AS "6-Yr Graduation"
, COUNT(CASE WHEN grad_term_28 = '1' and grad_term_24 = '0' and ssl_no_pell ='1' THEN student_cid END ) AS "7-Yr  Graduation"
, COUNT(CASE WHEN grad_term_29 = '0' THEN student_cid END ) AS "Not Graduated Within 7-Yrs"

FROM unc.uncw.da_gradret
WHERE cohort_term_code LIKE '%6'
AND student_full_part_time = 'F'
AND new_student_type = 'F'
AND grad_retn_from = '1'
and cohort_term_code <> '20246'

GROUP BY cohort_term_code
)

ORDER BY data_type, cohort_term_code


