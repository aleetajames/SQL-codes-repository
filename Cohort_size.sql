SELECT 
snapshot_term_code
, enrollment_status_ipeds AS "Student Type"
, 'Total'  AS "Cohort Type"
, COUNT (student_cid) AS cohort_size_original

FROM uncw.sdm_career_admit_mv
WHERE snapshot_term_code LIKE '%6'
and snapshot_type_code = '1'
and exclude_from_ipeds_flag = 'N'
and primary_career_flag = 'Y'
and career_code = 'U'
and enrollment_status_code_ipeds in ('1','5')

GROUP BY snapshot_term_code
, enrollment_status_ipeds

