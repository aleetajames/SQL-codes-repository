SELECT distinct a.student_cid,
a.rural
b.student_first_name
,b.student_middle_name
,b.student_last_name
,b.student_suffix
,b.student_date_of_birth
,cohort_term_code
, new_student_type_desc AS "Student Type"
, student_full_part_time AS "Student_FT_PT"

,  (CASE WHEN (exclude_1 = '0') THEN a.student_cid END) AS cohort_size_adj_1
,  (CASE WHEN (exclude_6 = '0') THEN a.student_cid END) AS cohort_size_adj_6
,  (CASE WHEN (exclude_8 = '0') THEN a.student_cid END) AS cohort_size_adj_8

, (CASE WHEN enrl_term_5 = '1'  and grad_term_4 = '0'  THEN a.student_cid END) AS "Returning to Yr2"
, (CASE WHEN grad_term_4 = '0' AND grad_term_8 = '1'  THEN a.student_cid END) AS "Graduating in 2Yrs"
, (CASE WHEN pers_term_9 = '1'  THEN a.student_cid END) AS "Persistiting in 2Yrs"



, (CASE WHEN enrl_term_9 = '1'  and grad_term_8 = '0'  THEN a.student_cid END) AS "Returning to Yr3"
, (CASE WHEN grad_term_8 = '0' AND grad_term_12 = '1'  THEN a.student_cid END) AS "Graduating in 3Yrs"
, (CASE WHEN pers_term_13 = '1'  THEN a.student_cid END) AS "Persistiting in 3Yrs"


, (CASE WHEN enrl_term_13 = '1'  and grad_term_12 = '0'  THEN a.student_cid END) AS "Returning to Yr4"
, (CASE WHEN grad_term_12 = '0' AND grad_term_16 = '1'  THEN a.student_cid END) AS "Graduating in 4Yrs"
, (CASE WHEN pers_term_17 = '1'  THEN a.student_cid END) AS "Persistiting in 4Yrs"


, (CASE WHEN enrl_term_17 = '1'  and grad_term_16 = '0'  THEN a.student_cid END) AS "Returning to Yr5"
, (CASE WHEN grad_term_16 = '0' AND grad_term_20 = '1'  THEN a.student_cid END) AS "Graduating in 5Yrs"
, (CASE WHEN pers_term_21 = '1'  THEN a.student_cid END) AS "Persistiting in 5Yrs"



, (CASE WHEN enrl_term_21 = '1'  and grad_term_20 = '0'  THEN a.student_cid END) AS "Returning to Yr6"
, (CASE WHEN grad_term_20 = '0' AND grad_term_24 = '1'  THEN a.student_cid END) AS "Graduating in 6Yrs"
, (CASE WHEN pers_term_25 = '1'  THEN a.student_cid END) AS "Persistiting in 6Yrs"


, (CASE WHEN enrl_term_25 = '1'  and grad_term_24 = '0'  THEN a.student_cid END) AS " Returning to Yr7"
, (CASE WHEN grad_term_24 = '0' AND grad_term_28 = '1'  THEN a.student_cid END) AS " Graduating in 7Yrs"
, (CASE WHEN pers_term_29 = '1'  THEN a.student_cid END) AS "Persistiting in 7Yrs"





FROM unc.uncw.da_gradret a

left JOIN (SELECT student_first_name
,student_middle_name
,student_last_name
,student_suffix
,student_date_of_birth 
, student_cid
,snapshot_term_code
FROM uncw.sdm_career_mv
where primary_career_flag = 'Y'
and exclude_from_ipeds_flag = 'N'
and snapshot_type_code = '1') b
on a.student_cid=b.student_cid 
and a.cohort_term_code=b.snapshot_term_code 

WHERE cohort_term_code = '20206'
--and cohort_term_code like '%6'
AND student_full_part_time = 'F'
AND new_student_type IN('F')
AND grad_retn_from = '1'
