SELECT 
snapshot_term_code
,student_cid

FROM uncw.sdm_career_admit_mv
WHERE snapshot_term_code ='20186'
and snapshot_type_code = '1'
and exclude_from_ipeds_flag = 'N'
and primary_career_flag = 'Y'
and career_code = 'U'
and enrollment_status_code_ipeds in ('1')