SELECT 
snapshot_term_code
,student_cid
,student_first_name
,student_middle_name
,student_last_name
,student_suffix
,student_date_of_birth
,enrollment_status_ipeds
,stdnt_race_ipeds

FROM uncw.sdm_career_mv

WHERE snapshot_term_code ='20166'
--and STUDENT_GENDER_IPEDS = 'F'
--and fa_pell_offer_flag = 'Y'
and snapshot_type_code = '1'
and exclude_from_ipeds_flag = 'N'
and primary_career_flag = 'Y'
and career_code = 'U'
and enrollment_status_code_ipeds in ('1', '2', '5','6')

