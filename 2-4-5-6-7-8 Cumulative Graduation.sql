
SELECT * FROM(

SELECT 
cohort_term_code
, 'Cumulative Graduation Headcount'  AS data_type
, COUNT (student_cid) AS cohort_size_original
, COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS cohort_size_adj_1
, COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS cohort_size_adj_6
, COUNT (CASE WHEN (exclude_8 = '0') THEN student_cid END) AS cohort_size_adj_8

, COUNT(CASE WHEN grad_term_8 = '1'  THEN student_cid END ) AS "2-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_16 = '1' THEN student_cid END ) AS "4-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_20 = '1' THEN student_cid END ) AS "5-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_24 = '1' THEN student_cid END ) AS "6-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_28 = '1' THEN student_cid END ) AS "7-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_32 = '1' THEN student_cid END ) AS "8-Yr Cumulative Graduation"
, COUNT(CASE WHEN grad_term_33 = '0' THEN student_cid END ) AS "Not Graduated Within 8-Yrs"
 
FROM unc.uncw.da_gradret
WHERE cohort_term_code LIKE '%6'
AND student_full_part_time = 'F'
AND new_student_type = 'F'
AND grad_retn_from = '1'

GROUP BY cohort_term_code



UNION ALL
SELECT
cohort_term_code
, 'Cumulative Graduation Rate' AS data_type
, COUNT (student_cid) AS cohort_size_original
, COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS cohort_size_adj_1
, COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS cohort_size_adj_6
, COUNT (CASE WHEN (exclude_8 = '0') THEN student_cid END) AS cohort_size_adj_8

, (CASE WHEN COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) = 0 THEN NULL ELSE ROUND(CAST (COUNT(CASE WHEN grad_term_8  = '1' THEN student_cid END ) AS FLOAT)/ CAST(COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS FLOAT),3) END) AS "2-Yr Cumulative Graduation"
, (CASE WHEN COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) = 0 THEN NULL ELSE ROUND(CAST (COUNT(CASE WHEN grad_term_16 = '1' THEN student_cid END ) AS FLOAT)/ CAST(COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS FLOAT),3) END) AS "4-Yr Cumulative Graduation"
, (CASE WHEN COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) = 0 THEN NULL ELSE ROUND(CAST (COUNT(CASE WHEN grad_term_20 = '1' THEN student_cid END ) AS FLOAT)/ CAST(COUNT (CASE WHEN (exclude_1 = '0') THEN student_cid END) AS FLOAT),3) END) AS "5-Yr Cumulative Graduation"
, (CASE WHEN COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) = 0  THEN NULL ELSE ROUND(CAST (COUNT(CASE WHEN grad_term_24 = '1' THEN student_cid END ) AS FLOAT)/ CAST(COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS FLOAT),3) END) AS "6-Yr Cumulative Graduation"
, (CASE WHEN COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) = 0  THEN NULL ELSE ROUND(CAST (COUNT(CASE WHEN grad_term_28 = '1' THEN student_cid END ) AS FLOAT)/ CAST(COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS FLOAT),3) END) AS "7-Yr Cumulative Graduation"
, (CASE WHEN COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) = 0  THEN NULL ELSE ROUND(CAST (COUNT(CASE WHEN grad_term_32 = '1' THEN student_cid END ) AS FLOAT)/ CAST(COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS FLOAT),3) END) AS "8-Yr Cumulative Graduation"
, (CASE WHEN COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) = 0  THEN NULL ELSE ROUND(CAST (COUNT(CASE WHEN grad_term_32 = '0' THEN student_cid END ) AS FLOAT)/ CAST(COUNT (CASE WHEN (exclude_6 = '0') THEN student_cid END) AS FLOAT),3) END) AS "Not Graduated Within 8-Yrs"


FROM unc.uncw.da_gradret
WHERE cohort_term_code LIKE '%6'
AND student_full_part_time = 'F'																																																													
AND new_student_type = 'F'
AND grad_retn_from = '1'

GROUP BY cohort_term_code    ORDER BY cohort_term_code                                                 
)
ORDER BY data_type, cohort_term_code
